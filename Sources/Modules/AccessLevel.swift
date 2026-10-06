@frozen
public enum AccessLevel: Hashable, Sendable {
    case `private`
    case `public`
}

extension AccessLevel: CustomDebugStringConvertible {
    
    @inlinable
    public var debugDescription: String {
        let description = switch self {
        case .private:
            "private"
        case .public:
            "public"
        }
        return "AccessScope.\(description)"
    }
}
