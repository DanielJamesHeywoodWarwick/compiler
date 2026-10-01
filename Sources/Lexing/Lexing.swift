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
                    let match = _1.prefixMatch(of: /[a-zA-Z_][a-zA-Z_0-9]*/).unsafelyUnwrapped
                    token = switch match.output {
                    case "external":
                        ._externalKeyword(atLine: lineNumber, column: columnNumber)
                    case "function":
                        ._functionKeyword(atLine: lineNumber, column: columnNumber)
                    case "public":
                        ._publicKeyword(atLine: lineNumber, column: columnNumber)
                    case "return":
                        ._returnKeyword(atLine: lineNumber, column: columnNumber)
                    default:
                        ._identifier(match.output, atLine: lineNumber, column: columnNumber)
                    }
                case "0"..."9":
                    let match = _1.prefixMatch(
                        of: /0b[01][01_]*|0o[0-7][0-7_]*|0x[0-9a-fA-F][0-9a-fA-F_]*|[0-9][0-9_]*/
                    ).unsafelyUnwrapped
                    token = ._integerLiteral(match.output, atLine: lineNumber, column: columnNumber)
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
                case "-" where _1.hasPrefix("->"):
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
