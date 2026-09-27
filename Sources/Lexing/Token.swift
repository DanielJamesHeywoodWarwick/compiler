@frozen
public struct Token {
    
    public enum Kind {}
    
    public let kind: Kind
    
    public let lineNumber: Int
    
    public let columnNumber: Int
    
    @inlinable
    internal init(_kind: Kind, atLine lineNumber: Int, column columnNumber: Int) {
        precondition(lineNumber >= 1, "Expected a line number of at least 1, but got \(lineNumber)")
        precondition(columnNumber >= 1, "Expected a column number of at least 1, but got \(columnNumber)")
        kind = _kind
        self.lineNumber = lineNumber
        self.columnNumber = columnNumber
    }
}
