import Tokens

@frozen
public struct `Type`: Hashable, Sendable {
    
    public let identifier: Identifier
    
    public let location: SourceLocation
    
    @inlinable
    public init(_ identifier: Identifier, at location: SourceLocation) {
        self.identifier = identifier
        self.location = location
    }
}

extension `Type`: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String { "Type(\"\(identifier)\", atLine: \(location.line), column: \(location.column))" }
}
