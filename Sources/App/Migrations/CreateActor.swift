import Fluent

struct CreateActor: Migration {
    
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("actors")
            .id()
            .field("name", .string)
            .create()
    }
    
    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema("actors").delete()
    }
}
