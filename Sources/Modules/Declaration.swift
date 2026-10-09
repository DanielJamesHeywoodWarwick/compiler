import Tokens

public struct Declaration: Hashable, Sendable {
    
    public enum Kind: Hashable, Sendable {
        case function(returnType: Type?, body: [Statement]?)
    }
    
    public enum AccessLevel: Hashable, Sendable {
        case `public`
    }
    
    public let kind: Kind
    
    public let name: Identifier
    
    public let accessLevel: AccessLevel?
    
    public let isExternal: Bool
    
    public let location: SourceLocation
    
    @inlinable
    internal init(_kind: Kind, name: Identifier, accessLevel: AccessLevel?, isExternal: Bool, at location: SourceLocation) {
        kind = _kind
        self.name = name
        self.accessLevel = accessLevel
        self.isExternal = isExternal
        self.location = location
    }
    
    @inlinable
    public static func function(
        _ name: Identifier,
        accessLevel: AccessLevel?,
        isExternal: Bool,
        returnType: Type?,
        body: [Statement]?,
        at location: SourceLocation
    ) -> Declaration {
        Declaration(
            _kind: .function(returnType: returnType, body: body),
            name: name,
            accessLevel: accessLevel,
            isExternal: isExternal,
            at: location
        )
    }
}

extension Declaration: CustomStringConvertible {
    
    @inlinable
    public var description: String {
        let locationDescription = "atLine: \(location.line), column: \(location.column)"
        return switch kind {
        case let .function(returnType, body):
            "function(\"\(name)\", accessLevel: \(accessLevel.map { level in "\(level)" } ?? "nil"), isExternal: \(isExternal), returnType: \(returnType?.description ?? "nil"), body: \(body.map { body in "[\(body.map(\.description).joined(separator: ", "))]" } ?? nil), \(locationDescription))"
        }
    }
}

extension Declaration: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String { "Modules.Declaration.\(self)" }
}

extension Declaration.Kind: CustomStringConvertible {
    
    @inlinable
    public var description: String {
        switch self {
        case let .function(returnType, body):
            "function(returnType: \(returnType?.description ?? "nil"), body: \(body.map { body in "[\(body.map(\.description).joined(separator: ", "))]" } ?? "nil"))"
        }
    }
}

extension Declaration.Kind: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String { "Modules.Declaration.Kind.\(self)" }
}
