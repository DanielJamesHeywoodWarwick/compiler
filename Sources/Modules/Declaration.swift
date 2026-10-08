import Tokens

public struct Declaration: Hashable, Sendable {
    
    public enum Kind: Hashable, Sendable {
        case function(returnType: `Type`, body: [Statement]?)
    }
    
    public let kind: Kind
    
    public let location: SourceLocation
}
