import Fluent
import Vapor

final class Actor: Model, Content {
    static var schema: String = "actors"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "name")
    var name: String
    
    @Siblings(through: MovieActor.self, from: \.$actor, to: \.$movie)
    var movies: [Movie]
    
    init() { }
    
    init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }
}
