@frozen
@resultBuilder public struct DeclarationsBuilder {
    
    @inlinable
    public static func buildBlock(_ components: [Declaration]...) -> [Declaration] { Array(components.joined()) }
    
    @inlinable
    public static func buildOptional(_ component: [Declaration]?) -> [Declaration] { component ?? [] }
}
