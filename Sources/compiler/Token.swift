struct Token {
    
    enum Kind {
        case identifier(String)
        case externalKeyword
        case functionKeyword
        case publicKeyword
        case returnKeyword
        case integerLiteral(words: [UInt])
        case openingParenthesis
        case closingParenthesis
        case openingAngleBracket
        case closingAngleBracket
        case openingBrace
        case closingBrace
        case arrow
    }
    
    var kind: Kind
    
    var lineNumber: Int
    
    var columnNumber: Int
    
    init(_ kind: Kind, atLine lineNumber: Int, column columnNumber: Int) {
        if case let .identifier(name) = kind {}
        if case let .integerLiteral(words) = kind {}
        precondition(lineNumber >= 1, "Expected a line number of at least 1, but got \(lineNumber)")
        precondition(columnNumber >= 1, "Expected a column number of at least 1, but got \(columnNumber)")
        self.kind = kind
        self.lineNumber = lineNumber
        self.columnNumber = columnNumber
    }
    
    static func identifier(_ name: String, atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(.identifier(name), atLine: lineNumber, column: columnNumber)
    }
    
    static func externalKeyword(atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(.externalKeyword, atLine: lineNumber, column: columnNumber)
    }
    
    static func functionKeyword(atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(.functionKeyword, atLine: lineNumber, column: columnNumber)
    }
    
    static func publicKeyword(atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(.publicKeyword, atLine: lineNumber, column: columnNumber)
    }
    
    static func returnKeyword(atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(.returnKeyword, atLine: lineNumber, column: columnNumber)
    }
    
    static func integerLiteral(words: [UInt], atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(.integerLiteral(words: words), atLine: lineNumber, column: columnNumber)
    }
    
    static func openingParenthesis(atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(.openingParenthesis, atLine: lineNumber, column: columnNumber)
    }
    
    static func closingParenthesis(atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(.closingParenthesis, atLine: lineNumber, column: columnNumber)
    }
    
    static func openingAngleBracket(atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(.openingAngleBracket, atLine: lineNumber, column: columnNumber)
    }
    
    static func closingAngleBracket(atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(.closingAngleBracket, atLine: lineNumber, column: columnNumber)
    }
    
    static func openingBrace(atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(.openingBrace, atLine: lineNumber, column: columnNumber)
    }
    
    static func closingBrace(atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(.closingBrace, atLine: lineNumber, column: columnNumber)
    }
    
    static func arrow(atLine lineNumber: Int, column columnNumber: Int) -> Token {
        Token(.arrow, atLine: lineNumber, column: columnNumber)
    }
}
