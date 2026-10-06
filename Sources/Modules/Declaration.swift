@frozen
public struct Declaration: Hashable, Sendable {
    
    public enum Kind: Hashable, Sendable {
        case function(body: [Statement])
    }
    
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
    
    @inlinable
    public static func function(
        atLine lineNumber: Int, column columnNumber: Int,
        @ArrayBuilder<Statement> makeBody: () -> [Statement]
    ) -> Declaration {
        Declaration(_kind: .function(body: makeBody()), atLine: lineNumber, column: columnNumber)
    }
}

extension Declaration: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String {
        switch kind {
        case .function:
            "function(atLine: \(lineNumber), column: \(columnNumber))"
        }
    }
}
