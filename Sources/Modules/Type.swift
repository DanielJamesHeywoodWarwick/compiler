import Tokens

public struct `Type`: Hashable, Sendable {
    
    public enum Kind: Hashable, Sendable {
        case identifier(Identifier)
    }
    
    public let kind: Kind
    
    public let location: SourceLocation?
    
    @inlinable
    internal init(_kind: Kind, at location: SourceLocation? = nil) {
        kind = _kind
        self.location = location
    }
    
    @inlinable
    public static func identifier(_ text: String) -> `Type` {
        Type(_kind: .identifier(Identifier(text)))
    }
}
