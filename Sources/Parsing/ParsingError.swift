import Tokens

public struct ParsingError: Hashable, Error {
    
    public enum Kind: Hashable, Sendable {
        case unexpectedEndOfFile
        case unexpectedToken(Token)
    }
    
    public enum Expectation: Hashable, Sendable {
        case type
        case expression
        case statement
    }
    
    public let kind: Kind
    
    public let expectation: Expectation
    
    @inlinable
    internal init(_kind: Kind, expecting expectation: Expectation) {
        kind = _kind
        self.expectation = expectation
    }
    
    @inlinable
    public static func unexpectedEndOfFile(expecting expectation: Expectation) -> ParsingError {
        ParsingError(_kind: .unexpectedEndOfFile, expecting: expectation)
    }
    
    @inlinable
    public static func unexpectedToken(_ token: Token, expecting expectation: Expectation) -> ParsingError {
        ParsingError(_kind: .unexpectedToken(token), expecting: expectation)
    }
}

extension ParsingError: CustomStringConvertible {
    
    @inlinable
    public var description: String {
        let kindDescription: String
        switch kind {
        case .unexpectedEndOfFile:
            kindDescription = "reached the end of the file"
        case let .unexpectedToken(token):
            let tokenKindDescription = switch token.kind {
            case .identifier:
                "the identifier"
            case .externalKeyword, .functionKeyword, .publicKeyword, .returnKeyword:
                "the keyword"
            case .integerLiteral:
                "the integer literal"
            case .openingParenthesis:
                "an opening parenthesis"
            case .closingParenthesis:
                "a closing parenthesis"
            case .openingBrace:
                "an opening brace"
            case .closingBrace:
                "a closing brace"
            case .arrow:
                "an arrow"
            }
            let tokenLocationDescription = "at line \(token.location.line), column \(token.location.column)"
            kindDescription = "got \(tokenKindDescription) '\(token)' \(tokenLocationDescription)"
        }
        let expectationDescription = switch expectation {
        case .type:
            "a type"
        case .expression:
            "an expression"
        case .statement:
            "a statement"
        }
        return "Expected \(expectationDescription), but \(kindDescription)"
    }
}

extension ParsingError: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String {
        "Parsing.ParsingError(kind: \(String(reflecting: kind)), expectation: \(String(reflecting: expectation)))"
    }
}
