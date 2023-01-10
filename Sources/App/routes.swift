import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    let moviesController = MoviesController()
    let reviewsController = ReviewsController()
    
    // POST /movies
    app.post("movies", use: moviesController.create)
    
    // GET /movies
    app.get("movies", use: moviesController.getAll)
    
    // DELETE /movies/movieId
    app.delete("movies", ":movieId", use: moviesController.delete)
    
    // POST /reviews
    app.post("reviews", use: reviewsController.create)
}
