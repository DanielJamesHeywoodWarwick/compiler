@frozen
public struct Module {
    
    @inlinable
    public init(@ArrayBuilder<Declaration> makeDeclarations: () -> [Declaration]) {}
}
