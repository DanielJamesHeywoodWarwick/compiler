public struct Identifier: Hashable, Sendable {
    
    @usableFromInline
    internal let _text: String
    
    @inlinable
    public init(_ text: String) {
        precondition(
            text.wholeMatch(of: /[a-zA-Z_][a-zA-Z_0-9]*/) != nil,
            "Expected an identifier, but got \(text.debugDescription)"
        )
        _text = text
    }
    
    @inlinable
    public init(_ text: Substring) {
        self.init(String(text))
    }
}

extension Identifier: CustomStringConvertible {
    
    @inlinable
    public var description: String { _text }
}

extension Identifier: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String { "Tokens.Identifier(\(_text.debugDescription))" }
}

extension Identifier: CustomReflectable {
    
    @inlinable
    public var customMirror: Mirror { Mirror(self, unlabeledChildren: [_text]) }
}
