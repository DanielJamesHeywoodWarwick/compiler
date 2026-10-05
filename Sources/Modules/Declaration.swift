import Tokens

@frozen
public struct Declaration: Hashable, Sendable {
    
    public enum Kind: Hashable, Sendable {
        case function
    }
    
    public let kind: Kind
    
    public let accessControl: AccessControl
    
    @inlinable
    internal init(_kind: Kind, accessControl: AccessControl) {
        kind = _kind
        self.accessControl = accessControl
    }
    
    @inlinable
    public static func function(accessControl: AccessControl) -> Declaration {
        Declaration(_kind: .function, accessControl: accessControl)
    }
}

extension Declaration: CustomStringConvertible {
    
    @inlinable
    public var description: String {
        switch kind {
        case .function:
            "function(accessControl: \(accessControl))"
        }
    }
}
