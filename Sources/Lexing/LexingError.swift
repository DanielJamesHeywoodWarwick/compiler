import Tokens

public struct LexingError: Hashable, Error {
    
    public enum Kind: Hashable, Sendable {
        case unexpectedCharacter(Character)
    }
    
    public let kind: Kind
    
    public let location: SourceLocation
    
    @inlinable
    internal init(_kind: Kind, atLine lineNumber: Int, column columnNumber: Int) {
        kind = _kind
        self.location = SourceLocation(line: lineNumber, column: columnNumber)
    }
    
    @inlinable
    public static func unexpectedCharacter(
        _ character: Character,
        atLine lineNumber: Int, column columnNumber: Int
    ) -> LexingError {
        LexingError(_kind: .unexpectedCharacter(character), atLine: lineNumber, column: columnNumber)
    }
}

extension LexingError: CustomStringConvertible {
    
    @inlinable
    public var description: String {
        let locationDescription = "at line \(location.line), column \(location.column)"
        return switch kind {
        case let .unexpectedCharacter(character):
            "Unexpected character '\(character)' \(locationDescription)"
        }
    }
}

extension LexingError: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String {
        let locationDescription = "atLine: \(location.line), column: \(location.column)"
        let description = switch kind {
        case let .unexpectedCharacter(character):
            "unexpectedCharacter(\(character.debugDescription), \(locationDescription))"
        }
        return "Lexing.LexingError.\(description)"
    }
}
