import Tokens

@frozen
public struct `Type`: Hashable, Sendable {
    
    public let identifier: Identifier
    
    public let lineNumber: Int
    
    public let columnNumber: Int
    
    @inlinable
    public init(_ identifier: Identifier, atLine lineNumber: Int, column columnNumber: Int) {
        self.identifier = identifier
        precondition(lineNumber >= 1, "Expected a line number of at least 1, but got \(lineNumber)")
        precondition(columnNumber >= 1, "Expected a column number of at least 1, but got \(columnNumber)")
        self.lineNumber = lineNumber
        self.columnNumber = columnNumber
    }
}

extension `Type`: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String { "Type(\"\(identifier)\", atLine: \(lineNumber), column: \(columnNumber))" }
}
