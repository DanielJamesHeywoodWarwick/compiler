@frozen
@resultBuilder
public enum ArrayBuilder<T> {
    
    @inlinable
    public static func buildBlock(_ components: [T]...) -> [T] { Array(components.joined()) }
    
    @inlinable
    public static func buildOptional(_ component: [T]?) -> [T] { component ?? [] }
}
