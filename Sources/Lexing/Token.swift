@frozen
public struct Token: Hashable, Sendable {
    
    public enum Kind: Hashable, Sendable {
        case identifier(Identifier)
        case externalKeyword
        case functionKeyword
        case publicKeyword
        case returnKeyword
        case integerLiteral(IntegerLiteral)
        case openingParenthesis
        case closingParenthesis
        case openingAngleBracket
        case closingAngleBracket
        case openingBrace
        case closingBrace
        case arrow
    }
    
    public let kind: Kind
    
    public let lineNumber: Int
    
    public let columnNumber: Int
    
    @inlinable
    internal init(_kind: Kind, atLine lineNumber: Int, column columnNumber: Int) {
        precondition(lineNumber >= 1, "Expected a line number of at least 1, but got \(lineNumber)")
        precondition(columnNumber >= 1, "Expected a column number of at least 1, but got \(columnNumber)")
        kind = _kind
        self.lineNumber = lineNumber
        self.columnNumber = columnNumber
    }
    
    @inlinable
    internal static func _identifier(_ text: String, atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(_kind: .identifier(Identifier(_text: text)), atLine: lineNumber, column: columnNumber)
    }
    
    @inlinable
    internal static func _externalKeyword(atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(_kind: .externalKeyword, atLine: lineNumber, column: columnNumber)
    }
    
    @inlinable
    internal static func _functionKeyword(atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(_kind: .functionKeyword, atLine: lineNumber, column: columnNumber)
    }
    
    @inlinable
    internal static func _publicKeyword(atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(_kind: .publicKeyword, atLine: lineNumber, column: columnNumber)
    }
    
    @inlinable
    internal static func _returnKeyword(atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(_kind: .returnKeyword, atLine: lineNumber, column: columnNumber)
    }
    
    @inlinable
    internal static func _integerLiteral(_ text: String, atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(_kind: .integerLiteral(IntegerLiteral(_text: text)), atLine: lineNumber, column: columnNumber)
    }
    
    @inlinable
    internal static func _openingParenthesis(atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(_kind: .openingParenthesis, atLine: lineNumber, column: columnNumber)
    }
    
    @inlinable
    internal static func _closingParenthesis(atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(_kind: .closingParenthesis, atLine: lineNumber, column: columnNumber)
    }
    
    @inlinable
    internal static func _openingAngleBracket(atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(_kind: .openingAngleBracket, atLine: lineNumber, column: columnNumber)
    }
    
    @inlinable
    internal static func _closingAngleBracket(atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(_kind: .closingAngleBracket, atLine: lineNumber, column: columnNumber)
    }
    
    @inlinable
    internal static func _openingBrace(atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(_kind: .openingBrace, atLine: lineNumber, column: columnNumber)
    }
    
    @inlinable
    internal static func _closingBrace(atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(_kind: .closingBrace, atLine: lineNumber, column: columnNumber)
    }
    
    @inlinable
    internal static func _arrow(atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(_kind: .arrow, atLine: lineNumber, column: columnNumber)
    }
}
