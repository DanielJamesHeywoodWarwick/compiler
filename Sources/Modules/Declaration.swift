import Tokens

public struct Declaration: Hashable, Sendable {
    
    public enum Kind: Hashable, Sendable {
        case function(Identifier, accessLevel: AccessLevel?, isExternal: Bool, returnType: Type?, body: [Statement]?)
    }
    
    public enum AccessLevel: Hashable, Sendable {
        case `public`
    }
    
    public let kind: Kind
    
    public let location: SourceLocation?
    
    @inlinable
    internal init(_kind: Kind, at location: SourceLocation?) {
        kind = _kind
        self.location = location
    }
    
    @inlinable
    public static func function(
        _ name: Identifier,
        accessLevel: AccessLevel?,
        isExternal: Bool,
        returnType: Type?,
        body: [Statement]?,
        at location: SourceLocation
    ) -> Declaration {
        Declaration(
            _kind: .function(name, accessLevel: accessLevel, isExternal: isExternal, returnType: returnType, body: body),
            at: location
        )
    }
}
