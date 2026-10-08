public struct Token: Hashable, Sendable {
    
    public enum Kind: Hashable, Sendable {
        case identifier(Identifier)
        case externalKeyword
        case functionKeyword
        case privateKeyword
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
    
    public let location: SourceLocation
    
    @inlinable
    internal init(_kind: Kind, at location: SourceLocation) {
        kind = _kind
        self.location = location
    }
    
    @inlinable
    public static func identifier(_ text: Substring, at location: SourceLocation) -> Token {
        Token(_kind: .identifier(Identifier(text)), at: location)
    }
    
    @inlinable
    public static func externalKeyword(at location: SourceLocation) -> Token {
        Token(_kind: .externalKeyword, at: location)
    }
    
    @inlinable
    public static func functionKeyword(at location: SourceLocation) -> Token {
        Token(_kind: .functionKeyword, at: location)
    }
    
    @inlinable
    public static func publicKeyword(at location: SourceLocation) -> Token {
        Token(_kind: .publicKeyword, at: location)
    }
    
    @inlinable
    public static func privateKeyword(at location: SourceLocation) -> Token {
        Token(_kind: .privateKeyword, at: location)
    }
    
    @inlinable
    public static func returnKeyword(at location: SourceLocation) -> Token {
        Token(_kind: .returnKeyword, at: location)
    }
    
    @inlinable
    public static func integerLiteral(_ text: Substring, at location: SourceLocation) -> Token {
        Token(_kind: .integerLiteral(IntegerLiteral(text)), at: location)
    }
    
    @inlinable
    public static func openingParenthesis(at location: SourceLocation) -> Token {
        Token(_kind: .openingParenthesis, at: location)
    }
    
    @inlinable
    public static func closingParenthesis(at location: SourceLocation) -> Token {
        Token(_kind: .closingParenthesis, at: location)
    }
    
    @inlinable
    public static func openingAngleBracket(at location: SourceLocation) -> Token {
        Token(_kind: .openingAngleBracket, at: location)
    }
    
    @inlinable
    public static func closingAngleBracket(at location: SourceLocation) -> Token {
        Token(_kind: .closingAngleBracket, at: location)
    }
    
    @inlinable
    public static func openingBrace(at location: SourceLocation) -> Token {
        Token(_kind: .openingBrace, at: location)
    }
    
    @inlinable
    public static func closingBrace(at location: SourceLocation) -> Token {
        Token(_kind: .closingBrace, at: location)
    }
    
    @inlinable
    public static func arrow(at location: SourceLocation) -> Token {
        Token(_kind: .arrow, at: location)
    }
}

extension Token: CustomStringConvertible {
    
    @inlinable
    public var description: String { kind.description }
}

extension Token: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String {
        let locationDescription = "atLine: \(location.line), column: \(location.column)"
        let description = switch kind {
        case let .identifier(identifier):
            "identifier(\"\(identifier)\", \(locationDescription))"
        case .externalKeyword:
            "externalKeyword(\(locationDescription))"
        case .functionKeyword:
            "functionKeyword(\(locationDescription))"
        case .privateKeyword:
            "privateKeyword(\(locationDescription))"
        case .publicKeyword:
            "publicKeyword(\(locationDescription))"
        case .returnKeyword:
            "returnKeyword(\(locationDescription))"
        case let .integerLiteral(literal):
            "integerLiteral(\"\(literal)\", \(locationDescription))"
        case .openingParenthesis:
            "openingParenthesis(\(locationDescription))"
        case .closingParenthesis:
            "closingParenthesis(\(locationDescription))"
        case .openingAngleBracket:
            "openingAngleBracket(\(locationDescription))"
        case .closingAngleBracket:
            "closingAngleBracket(\(locationDescription))"
        case .openingBrace:
            "openingBrace(\(locationDescription))"
        case .closingBrace:
            "closingBrace(\(locationDescription))"
        case .arrow:
            "arrow(\(locationDescription))"
        }
        return "Tokens.Token.\(description)"
    }
}

extension Token.Kind: CustomStringConvertible {
    
    @inlinable
    public var description: String {
        switch self {
        case let .identifier(identifier):
            identifier.description
        case .externalKeyword:
            "external"
        case .functionKeyword:
            "function"
        case .privateKeyword:
            "private"
        case .publicKeyword:
            "public"
        case .returnKeyword:
            "return"
        case let .integerLiteral(literal):
            literal.description
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
        let description = switch self {
        case let .identifier(identifier):
            "identifier(\"\(identifier)\")"
        case .externalKeyword:
            "externalKeyword"
        case .functionKeyword:
            "functionKeyword"
        case .privateKeyword:
            "privateKeyword"
        case .publicKeyword:
            "publicKeyword"
        case .returnKeyword:
            "returnKeyword"
        case let .integerLiteral(literal):
            "integerLiteral(\"\(literal)\")"
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
        return "Tokens.Token.Kind.\(description)"
    }
}
