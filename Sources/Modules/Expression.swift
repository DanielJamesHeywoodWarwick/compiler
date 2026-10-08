import Tokens

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

extension Expression: CustomStringConvertible {
    
    @inlinable
    public var description: String {
        let locationDescription = "atLine: \(location.line), column: \(location.column)"
        return switch kind {
        case let .integerLiteral(literal):
            "integerLiteral(\"\(literal)\", \(locationDescription))"
        }
    }
}

extension Expression: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String { "Modules.Expression.\(self)" }
}


extension Expression.Kind: CustomStringConvertible {
    
    @inlinable
    public var description: String {
        switch self {
        case let .integerLiteral(literal):
            "integerLiteral(\"\(literal)\")"
        }
    }
}

extension Expression.Kind: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String { "Modules.Expression.Kind.\(self)" }
}
