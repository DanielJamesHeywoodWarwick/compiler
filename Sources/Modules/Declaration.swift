import Tokens

public struct Declaration: Hashable, Sendable {
    
    public enum Kind: Hashable, Sendable {
        case function(returnType: `Type`?, body: [Statement]?)
    }
    
    public let kind: Kind
    
    public let isExternal: Bool
    
    public let location: SourceLocation
    
    @inlinable
    internal init(_kind: Kind, isExternal: Bool, at location: SourceLocation) {
        kind = _kind
        self.isExternal = isExternal
        self.location = location
    }
    
    @inlinable
    public static func function(
        isExternal: Bool = false,
        returnType: `Type`? = nil,
        at location: SourceLocation,
        @ArrayBuilder<Statement> makeBody: () -> [Statement]
    ) -> Declaration {
        Declaration(_kind: .function(returnType: returnType, body: makeBody()), isExternal: isExternal, at: location)
    }
}
