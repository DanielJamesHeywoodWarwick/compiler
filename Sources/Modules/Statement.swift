import Tokens

public struct Statement: Hashable, Sendable {
    
    public enum Kind: Hashable, Sendable {
        case `return`(Expression?)
    }
    
    public let kind: Kind
    
    public let location: SourceLocation
    
    @inlinable
    internal init(_kind: Kind, at location: SourceLocation) {
        kind = _kind
        self.location = location
    }
    
    @inlinable
    public static func `return`(_ expression: Expression?, at location: SourceLocation) -> Statement {
        Statement(_kind: .return(expression), at: location)
    }
}
