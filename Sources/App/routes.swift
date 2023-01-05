import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    // GET /movies
//    app.get("movies") { req -> EventLoopFuture<[Movie]> in
//        // Movie.query(on: req.db).all()
//        return Movie.query(on: req.db).with(\.$reviews).all()
//    }
    
    // GET movies and associated actors and reviews
    app.get("movies") { req in
        return Movie.query(on: req.db).with(\.$actors).with(\.$reviews).all()
    }
    
    // GET /movies/id
    app.get("movies", ":movieId") { req -> EventLoopFuture<Movie> in
        
        return Movie.find(req.parameters.get("movieId"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }
    
    // PUT /movies/id
    app.put("movies", ":movieId") { req -> EventLoopFuture<HTTPStatus> in
        
        let movie = try req.content.decode(Movie.self)
        
        return Movie.find(req.parameters.get("movieId"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                $0.title = movie.title
                return $0.update(on: req.db)
                    .transform(to: .ok)
            }
    }
    
    // POST /movies
    app.post("movies") { req -> EventLoopFuture<Movie> in
        
        let movie = try req.content.decode(Movie.self)  // content = body of http request
        
        return movie.create(on: req.db).map {
            return movie
        }
    }
    
    // DELETE /movies/id
    app.delete("movies", ":movieId") { req -> EventLoopFuture<HTTPStatus> in
        
        return Movie.find(req.parameters.get("movieId"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                $0.delete(on: req.db)
            }.transform(to: .ok)
    }
    
    // POST /reviews
    app.post("reviews") { req -> EventLoopFuture<Review> in
        
        let review = try req.content.decode(Review.self)
        return review.create(on: req.db).map { review }
    }
    
    // POST /actors
    app.post("actors") { req -> EventLoopFuture<Actor> in
        
        let actor = try req.content.decode(Actor.self)
        return actor.create(on: req.db).map { actor }
    }
    
    // POST movie/movieId/actor/actorId
    app.post("movie", ":movieId", "actor", ":actorId") { req -> EventLoopFuture<HTTPStatus> in
        
        // get the movie
        let movie = Movie.find(req.parameters.get("movieId"), on: req.db)
            .unwrap(or: Abort(.notFound))
        
        // get the actor
        let actor = Actor.find(req.parameters.get("actorId"), on: req.db)
            .unwrap(or: Abort(.notFound))
        
        return movie.and(actor).flatMap { (movie, actor) in
            movie.$actors.attach(actor, on: req.db)
        }.transform(to: .ok)
    }
    
    // GET Actors and related Movies
    app.get("actors") { req in
        return Actor.query(on: req.db).with(\.$movies).all()
    }
}
