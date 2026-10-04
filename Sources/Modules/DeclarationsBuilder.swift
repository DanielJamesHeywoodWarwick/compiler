@frozen
@resultBuilder public struct DeclarationsBuilder {
    
    @inlinable
    public static func buildBlock(_ components: [Declaration]...) -> [Declaration] { Array(components.joined()) }
}
