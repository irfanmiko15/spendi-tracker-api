import Vapor

extension Request {
    // MARK: Repositories
    var users: UserRepository { application.repositories.users.for(self) }
    var refreshTokens: RefreshTokenRepository { application.repositories.refreshTokens.for(self) }
    var emailTokens: EmailTokenRepository { application.repositories.emailTokens.for(self) }
    var passwordTokens: PasswordTokenRepository { application.repositories.passwordTokens.for(self) }
    var income: IncomeRepository { application.repositories.incomes.for(self) }
    var spendingMethod: SpendingMethodRepository { application.repositories.spendingMethods.for(self) }
    
}
