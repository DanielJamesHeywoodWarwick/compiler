import Tokens

@frozen
public struct Declaration: Hashable, Sendable {
    
    public enum Kind: Hashable, Sendable {
        case function(body: [Statement])
    }
    
    public let kind: Kind
    
    public let location: SourceLocation
    
    @inlinable
    internal init(_kind: Kind, at location: SourceLocation) {
        kind = _kind
        self.location = location
    }
    
    @inlinable
    public static func function(
        at location: SourceLocation,
        @ArrayBuilder<Statement> makeBody: () -> [Statement]
    ) -> Declaration {
        Declaration(_kind: .function(body: makeBody()), at: location)
    }
}

extension Declaration: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String {
        let description = switch kind {
        case let .function(body):
            "function(body: \(body), atLine: \(location.line), column: \(location.column))"
        }
        return "Declaration.\(description)"
    }
}

extension Declaration.Kind: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String {
        let description = switch self {
        case let .function(body):
            "function(body: \(body))"
        }
        return "Declaration.Kind.\(description)"
    }
}
