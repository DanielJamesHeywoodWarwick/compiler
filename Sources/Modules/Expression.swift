import Tokens

@frozen
public struct Expression: Hashable, Sendable {
    
    public enum Kind: Hashable, Sendable {
        case integerLiteral(IntegerLiteral)
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
    public static func integerLiteral(_ literal: IntegerLiteral, atLine lineNumber: Int, column columnNumber: Int) -> Expression {
        Expression(_kind: .integerLiteral(literal), atLine: lineNumber, column: columnNumber)
    }
}

extension Expression: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String {
        switch kind {
        case let .integerLiteral(literal):
            "integerLiteral(\"\(literal)\", atLine: \(lineNumber), column: \(columnNumber))"
        }
    }
}

extension Expression.Kind: CustomStringConvertible {
    
    @inlinable
    public var description: String {
        switch self {
        case let .integerLiteral(literal):
            "\(literal)"
        }
    }
}

extension Expression.Kind: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String {
        switch self {
        case let .integerLiteral(literal):
            "integerLiteral(\"\(literal)\")"
        }
    }
}
