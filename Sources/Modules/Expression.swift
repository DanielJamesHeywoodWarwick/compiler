@frozen
public struct Expression: Hashable, Sendable {
    
    public enum Kind: Hashable, Sendable {}
    
    public let kind: Kind
    
    public let lineNumber: Int
    
    public let columnNumber: Int
}
