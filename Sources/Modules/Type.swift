import Tokens

public struct Type: Hashable, Sendable {
    
    public enum Kind: Hashable, Sendable {
        case identifier(Identifier)
    }
    
    public let kind: Kind
    
    public let sourceRange: Range<SourceLocation>?
    
    @inlinable
    internal init(_kind: Kind, at location: SourceLocation) {
        kind = _kind
        let endLocation = switch kind {
        case let .identifier(name):
            SourceLocation(line: location.line, column: location.column + name.description.count)
        }
        sourceRange = Range(uncheckedBounds: (location, endLocation))
    }
    
    @inlinable
    public static func identifier(_ name: Identifier, at location: SourceLocation) -> Type {
        Type(_kind: .identifier(name), at: location)
    }
}
