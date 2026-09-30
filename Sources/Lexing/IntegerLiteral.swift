@frozen
public struct IntegerLiteral: Hashable, Sendable {
    
    @usableFromInline
    internal let _text: Substring
    
    @inlinable
    internal init(_text: Substring) {
        precondition(
            _text.wholeMatch(of: /0b[01][01_]*|0o[0-7][0-7_]*|[0-9][0-9_]*|0x[0-9a-fA-F][0-9a-fA-F_]*/) != nil,
            "Expected an integer literal, but got '\(_text)'"
        )
        self._text = _text
    }
}

extension IntegerLiteral: CustomStringConvertible {
    
    @inlinable
    public var description: String { String(_text) }
}

extension IntegerLiteral: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String { "IntegerLiteral(\(_text.debugDescription))" }
}

extension IntegerLiteral: CustomReflectable {
    
    @inlinable
    public var customMirror: Mirror { Mirror(self, unlabeledChildren: [_text]) }
}
