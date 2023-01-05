import Fluent
import Vapor

final class Review: Model, Content {
    static var schema: String = "reviews"
    
    @ID(key: .id)
    var id: UUID?
        
    @Field(key: "title")
    var title: String
    
    @Field(key: "body")
    var body: String
    
    // belongs to: Review belongs to a movie
    @Parent(key: "movie_id")     // Foreign Key
    var movie: Movie
    
    init() { }
    
    init(id: UUID? = nil, title: String, body: String, movieId: UUID) {
        self.id = id
        self.title = title
        self.body = body
        self.$movie.id = movieId
    }
}
