import Tokens

public struct `Type`: Hashable, Sendable {
    
    public enum Kind: Hashable, Sendable {
        case identifier(Identifier)
    }
    
    public let kind: Kind
    
    public let location: SourceLocation
}
