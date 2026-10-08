import Tokens

public struct Declaration: Hashable, Sendable {
    
    public enum Kind: Hashable, Sendable {
        case function(returnType: `Type`?, body: [Statement]?)
    }
    
    public enum AccessLevel: Hashable, Sendable {
        case `public`
    }
    
    public let kind: Kind
    
    public let accessLevel: AccessLevel?
    
    public let isExternal: Bool
    
    public let location: SourceLocation
    
    @inlinable
    internal init(_kind: Kind, accessLevel: AccessLevel?, isExternal: Bool, at location: SourceLocation) {
        kind = _kind
        self.accessLevel = accessLevel
        self.isExternal = isExternal
        self.location = location
    }
    
    @inlinable
    public static func function(
        accessLevel: AccessLevel? = nil,
        isExternal: Bool = false,
        returnType: `Type`? = nil,
        at location: SourceLocation,
        @ArrayBuilder<Statement> makeBody: () -> [Statement]
    ) -> Declaration {
        Declaration(
            _kind: .function(returnType: returnType, body: makeBody()),
            accessLevel: accessLevel,
            isExternal: isExternal,
            at: location
        )
    }
}
