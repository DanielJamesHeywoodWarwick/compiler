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
}
