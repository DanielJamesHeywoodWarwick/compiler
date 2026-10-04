@frozen
public struct Identifier: Hashable, Sendable {
    
    @usableFromInline
    internal let _text: Substring
    
    @inlinable
    public init(_ text: Substring) {
        precondition(
            text.wholeMatch(of: /[a-zA-Z_][a-zA-Z_0-9]*/) != nil,
            "Expected an identifier, but got \(text.debugDescription)"
        )
        _text = text
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
