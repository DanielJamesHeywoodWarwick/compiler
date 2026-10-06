@frozen
public struct Statement: Hashable, Sendable {
    
    public enum Kind: Hashable, Sendable {
        case `return`(Expression)
    }
    
    public let kind: Kind
    
    public let lineNumber: Int
    
    public let columnNumber: Int
    
    @inlinable
    internal init(_kind: Kind, atLine lineNumber: Int, column columnNumber: Int) {
        kind = _kind
        precondition(lineNumber >= 1, "Expected a line number of at least 1, but got \(lineNumber)")
        precondition(columnNumber >= 1, "Expected a column number of at least 1, but got \(columnNumber)")
        self.lineNumber = lineNumber
        self.columnNumber = columnNumber
    }
    
    @inlinable
    public static func `return`(_ expression: Expression, atLine lineNumber: Int, column columnNumber: Int) -> Statement {
        Statement(_kind: .return(expression), atLine: lineNumber, column: columnNumber)
    }
}

extension Statement: CustomStringConvertible {
    
    @inlinable
    public var description: String {
        switch kind {
        case let .return(expression):
            "return(\(expression), atLine: \(lineNumber), column: \(columnNumber))"
        }
    }
}

extension Statement: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String {
        switch kind {
        case let .return(expression):
            "Statement.return(\(expression), atLine: \(lineNumber), column: \(columnNumber))"
        }
    }
}

extension Statement.Kind: CustomStringConvertible {
    
    @inlinable
    public var description: String {
        switch self {
        case let .return(expression):
            "return(\(expression))"
        }
    }
}

extension Statement.Kind: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String {
        switch self {
        case let .return(expression):
            "Statement.Kind.return(\(expression))"
        }
    }
}
