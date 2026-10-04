@frozen
public struct Module {
    
    public let declarations: [Declaration]
    
    @inlinable
    public init(@ArrayBuilder<Declaration> makeDeclarations: () -> [Declaration]) {
        declarations = makeDeclarations()
    }
}
