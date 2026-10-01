@inlinable
public func tokens(for text: String) throws(LexingError) -> [Token] {
    var tokens = [] as [Token]
    for (lineNumber, line) in zip(1..., text.split(omittingEmptySubsequences: false, whereSeparator: \.isNewline)) {
        var _1 = line.prefix(upTo: line.firstRange(of: "//")?.lowerBound ?? line.endIndex)
        while let character = _1.first {
            if character.isWhitespace {
                _1 = _1.trimmingPrefix(while: \.isWhitespace)
            } else {
                let token: Token
                let columnNumber = line.distance(from: line.startIndex, to: _1.startIndex) + 1
                switch character {
                case "a"..."z", "A"..."Z", "_":
                    let _2 = _1.prefix(
                        while: { character in
                            "a"..."z" ~= character || "A"..."Z" ~= character || character == "_" || "0"..."9" ~= character
                        }
                    )
                    token = switch _2 {
                    case "external":
                        ._externalKeyword(atLine: lineNumber, column: columnNumber)
                    case "function":
                        ._functionKeyword(atLine: lineNumber, column: columnNumber)
                    case "public":
                        ._publicKeyword(atLine: lineNumber, column: columnNumber)
                    case "return":
                        ._returnKeyword(atLine: lineNumber, column: columnNumber)
                    default:
                        ._identifier(_2, atLine: lineNumber, column: columnNumber)
                    }
                case "0"..."9":
                    token = ._integerLiteral(
                        _1.prefix(while: { character in "0"..."9" ~= character || character == "_" }),
                        atLine: lineNumber, column: columnNumber
                    )
                case "(":
                    token = ._openingParenthesis(atLine: lineNumber, column: columnNumber)
                case ")":
                    token = ._closingParenthesis(atLine: lineNumber, column: columnNumber)
                case "<":
                    token = ._openingAngleBracket(atLine: lineNumber, column: columnNumber)
                case ">":
                    token = ._closingAngleBracket(atLine: lineNumber, column: columnNumber)
                case "{":
                    token = ._openingBrace(atLine: lineNumber, column: columnNumber)
                case "}":
                    token = ._closingBrace(atLine: lineNumber, column: columnNumber)
                case "-" where _1.dropFirst().first == ">":
                    token = ._arrow(atLine: lineNumber, column: columnNumber)
                default:
                    throw ._unexpectedCharacter(character, atLine: lineNumber, column: columnNumber)
                }
                _1 = _1.trimmingPrefix("\(token.kind)")
                tokens.append(token)
            }
        }
    }
    return tokens
}
