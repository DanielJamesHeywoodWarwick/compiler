import Tokens

@frozen
public struct Declaration: Hashable, Sendable {
    
    public enum Kind: Hashable, Sendable {
        case function
        case structure(declarations: [Declaration])
        case variable
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
        @ArrayBuilder<Declaration> makeDeclarations: () -> [Declaration]
    ) -> Declaration {
        Declaration(_kind: .structure(declarations: makeDeclarations()), accessControl: accessControl)
    }
}
