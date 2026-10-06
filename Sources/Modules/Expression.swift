import Tokens

@frozen
public struct Expression: Hashable, Sendable {
    
    public enum Kind: Hashable, Sendable {
        case integerLiteral(IntegerLiteral)
    }
    
    public let kind: Kind
    
    public let location: SourceLocation
    
    @inlinable
    internal init(_kind: Kind, at location: SourceLocation) {
        kind = _kind
        self.location = location
    }
    
    @inlinable
    public static func integerLiteral(_ literal: IntegerLiteral, at location: SourceLocation) -> Expression {
        Expression(_kind: .integerLiteral(literal), at: location)
    }
}

extension Expression: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String {
        let description = switch kind {
        case let .integerLiteral(literal):
            "integerLiteral(\"\(literal)\", atLine: \(location.line), column: \(location.column))"
        }
        return "Expression.\(description)"
    }
}

extension Expression.Kind: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String {
        let description = switch self {
        case let .integerLiteral(literal):
            "integerLiteral(\"\(literal)\")"
        }
        return "Expression.Kind.\(description)"
    }
}
