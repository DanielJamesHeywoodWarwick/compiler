import Tokens

@frozen
public struct `Type`: Hashable, Sendable {
    
    public let identifier: Identifier
}

extension `Type`: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String { "Type(\"\(identifier)\")" }
}
