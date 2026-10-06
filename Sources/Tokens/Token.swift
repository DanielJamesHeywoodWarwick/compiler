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
    public static func identifier(_ text: Substring, atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(_kind: .identifier(Identifier(text)), atLine: lineNumber, column: columnNumber)
    }
    
    @inlinable
    public static func externalKeyword(atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(_kind: .externalKeyword, atLine: lineNumber, column: columnNumber)
    }
    
    @inlinable
    public static func functionKeyword(atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(_kind: .functionKeyword, atLine: lineNumber, column: columnNumber)
    }
    
    @inlinable
    public static func publicKeyword(atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(_kind: .publicKeyword, atLine: lineNumber, column: columnNumber)
    }
    
    @inlinable
    public static func returnKeyword(atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(_kind: .returnKeyword, atLine: lineNumber, column: columnNumber)
    }
    
    @inlinable
    public static func integerLiteral(_ text: Substring, atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(_kind: .integerLiteral(IntegerLiteral(text)), atLine: lineNumber, column: columnNumber)
    }
    
    @inlinable
    public static func openingParenthesis(atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(_kind: .openingParenthesis, atLine: lineNumber, column: columnNumber)
    }
    
    @inlinable
    public static func closingParenthesis(atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(_kind: .closingParenthesis, atLine: lineNumber, column: columnNumber)
    }
    
    @inlinable
    public static func openingAngleBracket(atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(_kind: .openingAngleBracket, atLine: lineNumber, column: columnNumber)
    }
    
    @inlinable
    public static func closingAngleBracket(atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(_kind: .closingAngleBracket, atLine: lineNumber, column: columnNumber)
    }
    
    @inlinable
    public static func openingBrace(atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(_kind: .openingBrace, atLine: lineNumber, column: columnNumber)
    }
    
    @inlinable
    public static func closingBrace(atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(_kind: .closingBrace, atLine: lineNumber, column: columnNumber)
    }
    
    @inlinable
    public static func arrow(atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(_kind: .arrow, atLine: lineNumber, column: columnNumber)
    }
}

extension Token: CustomStringConvertible {
    
    @inlinable
    public var description: String { "\(kind)" }
}

extension Token: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String {
        switch kind {
        case let .identifier(identifier):
            "Token.identifier(\"\(identifier)\", atLine: \(lineNumber), column: \(columnNumber))"
        case .externalKeyword:
            "Token.externalKeyword(atLine: \(lineNumber), column: \(columnNumber))"
        case .functionKeyword:
            "Token.functionKeyword(atLine: \(lineNumber), column: \(columnNumber))"
        case .publicKeyword:
            "Token.publicKeyword(atLine: \(lineNumber), column: \(columnNumber))"
        case .returnKeyword:
            "Token.returnKeyword(atLine: \(lineNumber), column: \(columnNumber))"
        case let .integerLiteral(literal):
            "Token.integerLiteral(\"\(literal)\", atLine: \(lineNumber), column: \(columnNumber))"
        case .openingParenthesis:
            "Token.openingParenthesis(atLine: \(lineNumber), column: \(columnNumber))"
        case .closingParenthesis:
            "Token.closingParenthesis(atLine: \(lineNumber), column: \(columnNumber))"
        case .openingAngleBracket:
            "Token.openingAngleBracket(atLine: \(lineNumber), column: \(columnNumber))"
        case .closingAngleBracket:
            "Token.closingAngleBracket(atLine: \(lineNumber), column: \(columnNumber))"
        case .openingBrace:
            "Token.openingBrace(atLine: \(lineNumber), column: \(columnNumber))"
        case .closingBrace:
            "Token.closingBrace(atLine: \(lineNumber), column: \(columnNumber))"
        case .arrow:
            "Token.arrow(atLine: \(lineNumber), column: \(columnNumber))"
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
        case let .integerLiteral(literal):
            "\(literal)"
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
            "Token.Kind.identifier(\"\(identifier)\")"
        case .externalKeyword:
            "Token.Kind.externalKeyword"
        case .functionKeyword:
            "Token.Kind.functionKeyword"
        case .publicKeyword:
            "Token.Kind.publicKeyword"
        case .returnKeyword:
            "Token.Kind.returnKeyword"
        case let .integerLiteral(literal):
            "Token.Kind.integerLiteral(\"\(literal)\")"
        case .openingParenthesis:
            "Token.Kind.openingParenthesis"
        case .closingParenthesis:
            "Token.Kind.closingParenthesis"
        case .openingAngleBracket:
            "Token.Kind.openingAngleBracket"
        case .closingAngleBracket:
            "Token.Kind.closingAngleBracket"
        case .openingBrace:
            "Token.Kind.openingBrace"
        case .closingBrace:
            "Token.Kind.closingBrace"
        case .arrow:
            "Token.Kind.arrow"
        }
    }
}
