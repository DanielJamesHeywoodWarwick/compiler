@frozen
@resultBuilder
public enum ArrayBuilder<T> {
    
    @inlinable
    public static func buildBlock(_ components: [T]...) -> [T] { Array(components.joined()) }
    
    @inlinable
    public static func buildOptional(_ component: [T]?) -> [T] { component ?? [] }
    
    @inlinable
    public static func buildEither(first: [T]) -> [T] { first }
    
    @inlinable
    public static func buildEither(second: [T]) -> [T] { second }
    
    @inlinable
    public static func buildArray(_ components: [[T]]) -> [T] { Array(components.joined()) }
}
