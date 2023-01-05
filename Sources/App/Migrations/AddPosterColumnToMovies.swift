import Fluent

struct AddPosterColumnToMovies: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        
        return database.schema("movies")
            .field("poster", .string)
            .update()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        
        return database.schema("movies")
            .deleteField("poster")
            .delete()
    }
}
