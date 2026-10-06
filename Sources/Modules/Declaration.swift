import Tokens

@frozen
public struct Declaration: Hashable, Sendable {
    
    public enum Kind: Hashable, Sendable {
        case function(Identifier, accessLevel: AccessLevel, isExternal: Bool, returnType: `Type`, body: [Statement])
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
        _ identifier: Identifier,
        accessLevel: AccessLevel,
        isExternal: Bool = false,
        returnType: `Type`,
        at location: SourceLocation,
        @ArrayBuilder<Statement> makeBody: () -> [Statement]
    ) -> Declaration {
        Declaration(
            _kind: .function(
                identifier,
                accessLevel: accessLevel,
                isExternal: isExternal,
                returnType: returnType,
                body: makeBody()
            ),
            at: location
        )
    }
}

extension Declaration: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String {
        let description = switch kind {
        case let .function(identifier, accessLevel, isExternal, returnType, body):
            """
            function(\"\(identifier)\", accessLevel: \(accessLevel), isExternal: \(isExternal), returnType: \(returnType), \
            body: \(body), atLine: \(location.line), column: \(location.column)
            """
        }
        return "Declaration.\(description)"
    }
}

extension Declaration.Kind: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String {
        let description = switch self {
        case let .function(identifier, accessLevel, isExternal, returnType, body):
            """
            function(\"\(identifier)\", accessLevel: \(accessLevel), isExternal: \(isExternal), returnType: \(returnType), \
            body: \(body))
            """
        }
        return "Declaration.Kind.\(description)"
    }
}
