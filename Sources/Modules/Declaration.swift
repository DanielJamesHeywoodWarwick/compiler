import Tokens

public struct Declaration: Hashable, Sendable {
    
    public enum Kind: Hashable, Sendable {
        case function(body: [Statement]?)
    }
    
    public let kind: Kind
    
    public let location: SourceLocation
}
