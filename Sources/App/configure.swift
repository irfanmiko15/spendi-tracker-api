import Fluent
import FluentPostgresDriver
import Vapor
import JWT
import Mailgun
import QueuesRedisDriver

// configures your application
public func configure(_ app: Application) async throws {
    if app.environment != .testing {
        let jwksFilePath = app.directory.workingDirectory + (Environment.get("JWKS_KEYPAIR_FILE") ?? "keypair.jwks")
         guard
             let jwks = FileManager.default.contents(atPath: jwksFilePath),
             let jwksString = String(data: jwks, encoding: .utf8)
             else {
                 fatalError("Failed to load JWKS Keypair file at: \(jwksFilePath)")
         }
         try app.jwt.signers.use(jwksJSON: jwksString)
    }
    // register routes
    app.databases.use(DatabaseConfigurationFactory.postgres(configuration: .init(
            hostname: Environment.get("DATABASE_HOST") ?? "DATABASE_HOST",
            port: Environment.get("DATABASE_PORT").flatMap(Int.init(_:)) ?? SQLPostgresConfiguration.ianaPortNumber,
            username: Environment.get("DATABASE_USERNAME") ?? "DATABASE_USERNAME",
            password: Environment.get("DATABASE_PASSWORD") ?? "DATABASE_PASSWORD",
            database: Environment.get("DATABASE_NAME") ?? "DATABASE_NAME",
            tls: .prefer(try .init(configuration: .clientDefault)))
    ), as: .psql)
    app.middleware = .init()
    app.middleware.use(ErrorMiddleware.custom(environment: app.environment))
    
    // MARK: Model Middleware
    
    // MARK: Mailgun
    app.mailgun.configuration = .environment
    app.mailgun.defaultDomain = .sandbox
    
    // MARK: App Config
    app.config = .environment
    
    try routes(app)
    try migrations(app)
    try queues(app)
    try services(app)
    
    
    
    if app.environment == .development {
        try app.autoMigrate().wait()
        try app.queues.startInProcessJobs()
    }
    
}
