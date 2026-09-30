@frozen
public struct Identifier: Hashable, Sendable {
    
    @usableFromInline
    internal let _text: Substring
    
    @inlinable
    internal init(_text: Substring) {
        precondition(
            _text.wholeMatch(of: /[a-zA-Z_][a-zA-Z_0-9]*/) != nil,
            "Expected an identifier, but got \(_text.debugDescription)"
        )
        self._text = _text
    }
}

extension Identifier: CustomStringConvertible {
    
    @inlinable
    public var description: String { String(_text) }
}

extension Identifier: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String { "Identifier(\(_text.debugDescription))" }
}

extension Identifier: CustomReflectable {
    
    @inlinable
    public var customMirror: Mirror { Mirror(self, unlabeledChildren: [_text]) }
}
