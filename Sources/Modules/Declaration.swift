import Tokens

@frozen
public struct Declaration: Hashable, Sendable {
    
    public enum Kind: Hashable, Sendable {
        case structure(declarations: [Declaration])
    }
    
    public let kind: Kind
    
    @inlinable
    internal init(_kind: Kind) {
        kind = _kind
    }
    
    @inlinable
    public static func structure(@ArrayBuilder<Declaration> makeDeclarations: () -> [Declaration]) -> Declaration {
        Declaration(_kind: .structure(declarations: makeDeclarations()))
    }
}
