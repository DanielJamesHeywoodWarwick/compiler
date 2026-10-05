import Tokens

@frozen
public struct Declaration: Hashable, Sendable {
    
    public enum Kind: Hashable, Sendable {
        case function
        case structure(members: [Declaration])
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
    
    @inlinable
    public static func structure(
        accessControl: AccessControl,
        @ArrayBuilder<Declaration> makeMembers: () -> [Declaration]
    ) -> Declaration {
        Declaration(_kind: .structure(members: makeMembers()), accessControl: accessControl)
    }
}

extension Declaration: CustomStringConvertible {
    
    @inlinable
    public var description: String {
        switch kind {
        case .function:
            "function(accessControl: \(accessControl))"
        case let .structure(members):
            "structure(accessControl: \(accessControl), members: \(members))"
        }
    }
}
