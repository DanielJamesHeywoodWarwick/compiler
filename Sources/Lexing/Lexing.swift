@inlinable
public func tokens(for text: String) throws(LexingError) -> [Token] {
    var tokens = [] as [Token]
    for (lineNumber, line) in zip(1..., text.split(omittingEmptySubsequences: false, whereSeparator: \.isNewline)) {
        var _1 = line.prefix(upTo: line.firstRange(of: "//")?.lowerBound ?? line.endIndex)
        while let character = _1.first {
            if character.isWhitespace {
                _1 = _1.trimmingPrefix(while: \.isWhitespace)
            } else {
                let columnNumber = line.distance(from: line.startIndex, to: _1.startIndex) + 1
                let token = switch character {
                case "a"..."z", "A"..."Z", "_":
                    ._identifier(
                        _1.prefix(
                            while: { character in
                                "a"..."z" ~= character || "A"..."Z" ~= character || character == "_" || "0"..."9" ~= character
                            }
                        ),
                        atLine: lineNumber, column: columnNumber
                    )
                case "0"..."9":
                    ._integerLiteral(
                        _1.prefix(while: { character in "0"..."9" ~= character || character == "_" }),
                        atLine: lineNumber, column: columnNumber
                    )
                case "(":
                    ._openingParenthesis(atLine: lineNumber, column: columnNumber)
                case ")":
                    ._closingParenthesis(atLine: lineNumber, column: columnNumber)
                case "<":
                    ._openingAngleBracket(atLine: lineNumber, column: columnNumber)
                case ">":
                    ._closingAngleBracket(atLine: lineNumber, column: columnNumber)
                case "{":
                    ._openingBrace(atLine: lineNumber, column: columnNumber)
                case "}":
                    ._closingBrace(atLine: lineNumber, column: columnNumber)
                case "-" where _1.dropFirst().first == ">":
                    ._arrow(atLine: lineNumber, column: columnNumber)
                default:
                    throw ._unexpectedCharacter(character, atLine: lineNumber, column: columnNumber)
                } as Token
                _1 = _1.trimmingPrefix("\(token.kind)")
                tokens.append(token)
            }
        }
    }
    return tokens
}
