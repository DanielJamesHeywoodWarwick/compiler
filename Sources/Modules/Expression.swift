import Tokens

public struct Expression: Hashable, Sendable {
    
    public enum Kind: Hashable, Sendable {
        case integerLiteral(IntegerLiteral)
    }
    
    public let kind: Kind
    
    public let sourceRange: Range<SourceLocation>?
    
    @inlinable
    internal init(_kind: Kind, at location: SourceLocation) {
        kind = _kind
        let endLocation = switch kind {
        case let .integerLiteral(literal):
            SourceLocation(line: location.line, column: location.column + literal.description.count)
        }
        sourceRange = Range(uncheckedBounds: (location, endLocation))
    }
    
    @inlinable
    public static func integerLiteral(_ literal: IntegerLiteral, at location: SourceLocation) -> Expression {
        Expression(_kind: .integerLiteral(literal), at: location)
    }
}
