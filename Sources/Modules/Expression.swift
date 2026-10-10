import Tokens

public struct Expression: Hashable, Sendable {
    
    public enum Kind: Hashable, Sendable {
        case integerLiteral(IntegerLiteral)
    }
    
    public let kind: Kind
    
    public let location: SourceLocation?
    
    @inlinable
    internal init(_kind: Kind, at location: SourceLocation?) {
        kind = _kind
        self.location = location
    }
    
    @inlinable
    public static func integerLiteral(_ literal: IntegerLiteral, at location: SourceLocation) -> Expression {
        Expression(_kind: .integerLiteral(literal), at: location)
    }
}
