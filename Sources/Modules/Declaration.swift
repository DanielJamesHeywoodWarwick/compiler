import Tokens

@frozen
public struct Declaration: Hashable, Sendable {
    
    public enum Kind: Hashable, Sendable {
        case function(isExternal: Bool)
        case structure(isExternal: Bool, declarations: [Declaration])
        case variable(isExternal: Bool)
    }
    
    public let kind: Kind
    
    public let accessControl: AccessControl
    
    @inlinable
    internal init(_kind: Kind, accessControl: AccessControl) {
        kind = _kind
        self.accessControl = accessControl
    }
    
    @inlinable
    public static func function(accessControl: AccessControl, isExternal: Bool = false) -> Declaration {
        Declaration(_kind: .function(isExternal: isExternal), accessControl: accessControl)
    }
    
    @inlinable
    public static func structure(
        _ name: String,
        accessControl: AccessControl,
        isExternal: Bool = false,
        @ArrayBuilder<Declaration> makeDeclarations: () -> [Declaration]
    ) -> Declaration {
        Declaration(_kind: .structure(isExternal: isExternal, declarations: makeDeclarations()), accessControl: accessControl)
    }
}
