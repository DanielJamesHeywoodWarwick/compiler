import Tokens

public struct Expression: Hashable, Sendable {
    
    public enum Kind: Hashable, Sendable {
        case integerLiteral(IntegerLiteral)
    }
    
    public let kind: Kind
    
    public let location: SourceLocation
}
