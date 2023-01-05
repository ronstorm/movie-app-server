import Fluent

struct CreateMovie: Migration {
    
    // Actual migration: CRUD operation
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("movies")    // table name
                .id()
                .field("title", .string)    // column name
                .create()
    }
    
    // Undo operation
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("movies")
                .delete()
    }
}

