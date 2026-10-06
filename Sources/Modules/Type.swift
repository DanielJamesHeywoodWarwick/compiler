import Tokens

@frozen
public struct `Type`: Hashable, Sendable {
    
    public let identifier: Identifier
    
    @inlinable
    public init(_ identifier: Identifier) {
        self.identifier = identifier
    }
}

extension `Type`: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String { "Type(\"\(identifier)\")" }
}
