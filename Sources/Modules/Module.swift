@frozen
public struct Module: Hashable, Sendable {
    
    public let declarations: [Declaration]
    
    @inlinable
    public init(@ArrayBuilder<Declaration> makeDeclarations: () -> [Declaration]) {
        declarations = makeDeclarations()
    }
}
