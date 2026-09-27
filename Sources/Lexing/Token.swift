@frozen
public struct Token {
    
    public let lineNumber: Int
    
    public let columnNumber: Int
    
    @inlinable
    internal init(atLine lineNumber: Int, column columnNumber: Int) {
        precondition(lineNumber >= 1, "Expected a line number of at least 1, but got \(lineNumber)")
        precondition(columnNumber >= 1, "Expected a column number of at least 1, but got \(columnNumber)")
        self.lineNumber = lineNumber
        self.columnNumber = columnNumber
    }
}
