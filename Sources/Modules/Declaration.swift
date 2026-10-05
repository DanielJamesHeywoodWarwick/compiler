import Tokens

@frozen
public struct Declaration: Hashable, Sendable {
    
    public enum Kind: Hashable, Sendable {
        case function
        case structure(members: [Declaration])
    }
    
    public let kind: Kind
    
    public let identifier: Identifier
    
    public let accessControl: AccessControl
    
    @inlinable
    internal init(_kind: Kind, identifierText: String, accessControl: AccessControl) {
        kind = _kind
        self.identifier = Identifier(identifierText)
        self.accessControl = accessControl
    }
    
    @inlinable
    public static func function(_ identifierText: String, accessControl: AccessControl) -> Declaration {
        Declaration(_kind: .function, identifierText: identifierText, accessControl: accessControl)
    }
    
    @inlinable
    public static func structure(
        _ identifierText: String,
        accessControl: AccessControl,
        @ArrayBuilder<Declaration> makeMembers: () -> [Declaration]
    ) -> Declaration {
        Declaration(_kind: .structure(members: makeMembers()), identifierText: identifierText, accessControl: accessControl)
    }
}

extension Declaration: CustomStringConvertible {
    
    @inlinable
    public var description: String {
        switch kind {
        case .function:
            "function(\"\(identifier)\", accessControl: \(accessControl))"
        case let .structure(members):
            "structure(\"\(identifier)\", accessControl: \(accessControl), members: \(members))"
        }
    }
}
