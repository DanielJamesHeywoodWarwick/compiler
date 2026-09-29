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
        kind = _kind
        precondition(lineNumber >= 1, "Expected a line number of at least 1, but got \(lineNumber)")
        precondition(columnNumber >= 1, "Expected a column number of at least 1, but got \(columnNumber)")
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

extension Token: CustomStringConvertible {
    
    @inlinable
    public var description: String {
        switch kind {
        case let .identifier(identifier):
            "identifier(\"\(identifier)\", atLine: \(lineNumber), column: \(columnNumber))"
        case .externalKeyword:
            "externalKeyword(atLine: \(lineNumber), column: \(columnNumber))"
        case .functionKeyword:
            "functionKeyword(atLine: \(lineNumber), column: \(columnNumber))"
        case .publicKeyword:
            "publicKeyword(atLine: \(lineNumber), column: \(columnNumber))"
        case .returnKeyword:
            "returnKeyword(atLine: \(lineNumber), column: \(columnNumber))"
        case let .integerLiteral(integerLiteral):
            "integerLiteral(\"\(integerLiteral)\", atLine: \(lineNumber), column: \(columnNumber))"
        case .openingParenthesis:
            "openingParenthesis(atLine: \(lineNumber), column: \(columnNumber))"
        case .closingParenthesis:
            "closingParenthesis(atLine: \(lineNumber), column: \(columnNumber))"
        case .openingAngleBracket:
            "openingAngleBracket(atLine: \(lineNumber), column: \(columnNumber))"
        case .closingAngleBracket:
            "closingAngleBracket(atLine: \(lineNumber), column: \(columnNumber))"
        case .openingBrace:
            "openingBrace(atLine: \(lineNumber), column: \(columnNumber))"
        case .closingBrace:
            "closingBrace(atLine: \(lineNumber), column: \(columnNumber))"
        case .arrow:
            "arrow(atLine: \(lineNumber), column: \(columnNumber))"
        }
    }
}

extension Token.Kind: CustomStringConvertible {
    
    @inlinable
    public var description: String {
        switch self {
        case let .identifier(identifier):
            "\(identifier)"
        case .externalKeyword:
            "external"
        case .functionKeyword:
            "function"
        case .publicKeyword:
            "public"
        case .returnKeyword:
            "return"
        case let .integerLiteral(integerLiteral):
            "\(integerLiteral)"
        case .openingParenthesis:
            "("
        case .closingParenthesis:
            ")"
        case .openingAngleBracket:
            "<"
        case .closingAngleBracket:
            ">"
        case .openingBrace:
            "{"
        case .closingBrace:
            "}"
        case .arrow:
            "->"
        }
    }
}

extension Token.Kind: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String {
        switch self {
        case let .identifier(identifier):
            "identifier(\"\(identifier)\")"
        case .externalKeyword:
            "externalKeyword"
        case .functionKeyword:
            "functionKeyword"
        case .publicKeyword:
            "publicKeyword"
        case .returnKeyword:
            "returnKeyword"
        case let .integerLiteral(integerLiteral):
            "integerLiteral(\"\(integerLiteral)\")"
        case .openingParenthesis:
            "openingParenthesis"
        case .closingParenthesis:
            "closingParenthesis"
        case .openingAngleBracket:
            "openingAngleBracket"
        case .closingAngleBracket:
            "closingAngleBracket"
        case .openingBrace:
            "openingBrace"
        case .closingBrace:
            "closingBrace"
        case .arrow:
            "arrow"
        }
    }
}
