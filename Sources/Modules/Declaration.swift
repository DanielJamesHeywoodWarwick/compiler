@frozen
public struct Declaration: Hashable, Sendable {
    
    public enum Kind: Hashable, Sendable {}
    
    public let kind: Kind
    
    public let lineNumber: Int
    
    public let columnNumber: Int
    
    @inlinable
    internal init(_kind: Kind, atLine lineNumber: Int, column columnNumber: Int) {
        kind = _kind
        precondition(lineNumber >= 1, "Expected a line number of at least 1, but got \(lineNumber)")
        precondition(columnNumber >= 1, "Expected a column number of at least 1, but got \(columnNumber)")
        self.lineNumber = lineNumber
        self.columnNumber = columnNumber
    }
}

extension Declaration: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String {
        switch kind {}
    }
}

extension Declaration.Kind: CustomStringConvertible {
    
    @inlinable
    public var description: String {
        switch self {}
    }
}

extension Declaration.Kind: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String {
        switch self {}
    }
}
