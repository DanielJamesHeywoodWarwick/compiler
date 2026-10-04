@frozen
public struct Module {
    
    @inlinable
    public init(@DeclarationsBuilder makeDeclarations: () -> [Declaration]) {}
}
