import Tokens

public struct Type: Hashable, Sendable {
    
    public enum Kind: Hashable, Sendable {
        case identifier(Identifier)
    }
    
    public let kind: Kind
    
    public let location: SourceLocation
    
    @inlinable
    internal init(_kind: Kind, at location: SourceLocation) {
        kind = _kind
        self.location = location
    }
    
    @inlinable
    public static func identifier(_ name: Identifier, at location: SourceLocation) -> Type {
        Type(_kind: .identifier(name), at: location)
    }
}

extension Type: CustomStringConvertible {
    
    @inlinable
    public var description: String {
        let locationDescription = "atLine: \(location.line), column: \(location.column)"
        return switch kind {
        case let .identifier(name):
            _description(of: "identifier", argumentDescriptions: "\"\(name)\"", locationDescription)
        }
    }
}

extension Type: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String { "Modules.Type.\(self)" }
}


extension Type.Kind: CustomStringConvertible {
    
    @inlinable
    public var description: String {
        switch self {
        case let .identifier(name):
            _description(of: "identifier", argumentDescriptions: "\"\(name)\"")
        }
    }
}

extension Type.Kind: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String { "Modules.Type.Kind.\(self)" }
}
