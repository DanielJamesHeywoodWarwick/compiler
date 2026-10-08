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
    public static func `return`(_ expression: Expression? = nil, at location: SourceLocation) -> Statement {
        Statement(_kind: .return(expression), at: location)
    }
}

extension Statement: CustomStringConvertible {
    
    @inlinable
    public var description: String {
        let locationDescription = "atLine: \(location.line), column: \(location.column)"
        return switch kind {
        case let .return(expression):
            "return(\(expression.map { expression in "\(expression), " } ?? "")\(locationDescription))"
        }
    }
}

extension Statement: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String { "Modules.Statement.\(self)" }
}

extension Statement.Kind: CustomStringConvertible {
    
    @inlinable
    public var description: String {
        switch self {
        case let .return(expression):
            "return\(expression.map { expression in "(\(expression))" } ?? "")"
        }
    }
}

extension Statement.Kind: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String { "Modules.Statement.Kind.\(self)" }
}
