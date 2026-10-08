import Tokens

public struct Declaration: Hashable, Sendable {
    
    public enum Kind: Hashable, Sendable {
        case function
    }
    
    public let kind: Kind
    
    public let location: SourceLocation
}
