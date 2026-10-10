import Tokens

public struct Statement: Hashable, Sendable {
    
    public enum Kind: Hashable, Sendable {
        case `return`(Expression?)
    }
    
    public let kind: Kind
    
    public let startLocation: SourceLocation?
    
    public let endLocation: SourceLocation?
    
    @inlinable
    internal init(_kind: Kind, at location: SourceLocation) {
        kind = _kind
        startLocation = location
        endLocation = switch kind {
        case let .return(expression):
            expression?.endLocation ?? SourceLocation(line: location.line, column: location.column + 6)
        }
    }
    
    @inlinable
    public static func `return`(_ expression: Expression?, at location: SourceLocation) -> Statement {
        Statement(_kind: .return(expression), at: location)
    }
}
