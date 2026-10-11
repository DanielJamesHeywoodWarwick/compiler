public struct Module: Hashable, Sendable {
    
    public let declarations: [Declaration]
    
    @inlinable
    public init(declarations: [Declaration]) {
        self.declarations = declarations
    }
}
