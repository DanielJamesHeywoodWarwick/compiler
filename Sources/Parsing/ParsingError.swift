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
