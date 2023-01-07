import Vapor

final class MoviesController {
    
    func create(_ req: Request) throws -> EventLoopFuture<Movie> {
        let movie = try req.content.decode(Movie.self)
        return movie.create(on: req.db).map { movie }
    }
    
    func getAll(_ req: Request) -> EventLoopFuture<[Movie]> {
        Movie.query(on: req.db).all()
    }
    
    func delete(_ req: Request) -> EventLoopFuture<HTTPStatus> {
        Movie.find(req.parameters.get("movieId"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap {
                $0.delete(on: req.db)
            }.transform(to: .ok)
    }
}
