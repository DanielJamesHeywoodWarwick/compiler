import Tokens

@frozen
public struct Statement: Hashable, Sendable {
    
    public enum Kind: Hashable, Sendable {
        case `return`(Expression)
    }
    
    public let kind: Kind
    
    public let location: SourceLocation
    
    @inlinable
    internal init(_kind: Kind, at location: SourceLocation) {
        kind = _kind
        self.location = location
    }
    
    @inlinable
    public static func `return`(_ expression: Expression, at location: SourceLocation) -> Statement {
        Statement(_kind: .return(expression), at: location)
    }
}

extension Statement: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String {
        let description = switch kind {
        case let .return(expression):
            "return(\(expression), atLine: \(location.line), column: \(location.column))"
        }
        return "Statement.\(description)"
    }
}

extension Statement.Kind: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String {
        let description = switch self {
        case let .return(expression):
            "return(\(expression))"
        }
        return "Statement.Kind.\(description)"
    }
}
