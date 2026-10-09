import Tokens

public struct LexingError: Hashable, Error {
    
    public enum Kind: Hashable, Sendable {
        case unexpectedCharacter(Character)
    }
    
    public let kind: Kind
    
    public let location: SourceLocation
    
    @inlinable
    internal init(_kind: Kind, at location: SourceLocation) {
        kind = _kind
        self.location = location
    }
    
    @inlinable
    public static func unexpectedCharacter(_ character: Character, at location: SourceLocation) -> LexingError {
        LexingError(_kind: .unexpectedCharacter(character), at: location)
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
        let description = switch kind {
        case let .unexpectedCharacter(character):
            "unexpectedCharacter(\(character.debugDescription), \(String(reflecting: location)))"
        }
        return "Lexing.LexingError.\(description)"
    }
}
