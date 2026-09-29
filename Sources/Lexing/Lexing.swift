@inlinable
public func tokens(for text: String) throws(LexingError) -> [Token] {
    var tokens = [] as [Token]
    for (lineNumber, line) in zip(1..., text.split(separator: /\R/, omittingEmptySubsequences: false)) {}
    return tokens
}
