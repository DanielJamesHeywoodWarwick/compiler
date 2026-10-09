@inlinable
internal func _description(of name: String, argumentDescriptions: String?...) -> String {
    let argumentDescriptions = argumentDescriptions.compactMap(\.self)
    return argumentDescriptions.isEmpty ? name : "\(name)(\(argumentDescriptions.joined(separator: ", ")))"
}
