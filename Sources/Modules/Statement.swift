import Tokens

public struct Statement: Hashable, Sendable {
    
    public enum Kind: Hashable, Sendable {
        case `return`(Expression?)
    }
    
    public let kind: Kind
    
    public let sourceRange: Range<SourceLocation>?
    
    @inlinable
    internal init(_kind: Kind, at location: SourceLocation) {
        kind = _kind
        let endLocation: SourceLocation
        switch kind {
        case let .return(expression):
            if let expression {
                guard let expressionSourceRange = expression.sourceRange else {
                    preconditionFailure()
                }
                endLocation = expressionSourceRange.upperBound
            } else {
                endLocation = SourceLocation(line: location.line, column: location.column + 6)
            }
        }
        sourceRange = Range(uncheckedBounds: (location, endLocation))
    }
    
    @inlinable
    public static func `return`(_ expression: Expression?, at location: SourceLocation) -> Statement {
        Statement(_kind: .return(expression), at: location)
    }
}
