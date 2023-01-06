import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    let moviesController = MoviesController()
    
    // POST /movies
    app.post("movies", use: moviesController.create)
    
    // GET /movies
    app.get("movies", use: moviesController.getAll)
}
