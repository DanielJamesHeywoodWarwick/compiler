@frozen
public struct LexingError: Hashable, Error {
    
    public enum Kind: Hashable, Sendable {
        case unexpectedCharacter(Character)
        case unterminatedMultilineComment
        case unexpectedMultilineCommentTerminator
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
    internal static func _unexpectedCharacter(
        _ character: Character,
        atLine lineNumber: Int, column columnNumber: Int
    ) -> LexingError {
        LexingError(_kind: .unexpectedCharacter(character), atLine: lineNumber, column: columnNumber)
    }

    @inlinable
    internal static func _unterminatedMultilineComment(atLine lineNumber: Int, column columnNumber: Int) -> LexingError {
        LexingError(_kind: .unterminatedMultilineComment, atLine: lineNumber, column: columnNumber)
    }
    
    @inlinable
    internal static func _unexpectedMultilineCommentTerminator(atLine lineNumber: Int, column columnNumber: Int) -> LexingError {
        LexingError(_kind: .unexpectedMultilineCommentTerminator, atLine: lineNumber, column: columnNumber)
    }
}

extension LexingError: CustomStringConvertible {
    
    @inlinable
    public var description: String {
        switch kind {
        case let .unexpectedCharacter(character):
            "Unexpected character '\(character)' at line \(lineNumber), column \(columnNumber)"
        case .unterminatedMultilineComment:
            "Unterminated multiline comment at line \(lineNumber), column \(columnNumber)"
        case .unexpectedMultilineCommentTerminator:
            "Unexpected multiline comment terminator '*/' at line \(lineNumber), column \(columnNumber)"
        }
    }
}

extension LexingError: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String {
        switch kind {
        case let .unexpectedCharacter(character):
            "unexpectedCharacter(\(character.debugDescription), atLine: \(lineNumber), column: \(columnNumber))"
        case .unterminatedMultilineComment:
            "unterminatedMultilineComment(atLine: \(lineNumber), column: \(columnNumber))"
        case .unexpectedMultilineCommentTerminator:
            "unexpectedMultilineCommentTerminator(atLine: \(lineNumber), column: \(columnNumber))"
        }
    }
}
