import Tokens

public struct Statement: Hashable, Sendable {
    
    public enum Kind: Hashable, Sendable {
        case `return`
    }
    
    public let kind: Kind
    
    public let location: SourceLocation
}
