import Tokens

@inlinable
public func tokens(for text: String) throws(LexingError) -> [Token] {
    var tokens = [] as [Token]
    for (lineNumber, line) in zip(1..., text.split(omittingEmptySubsequences: false, whereSeparator: \.isNewline)) {
        var unlexedText = line.prefix(upTo: line.firstRange(of: "//")?.lowerBound ?? line.endIndex)
        while let character = unlexedText.first {
            if character.isWhitespace {
                unlexedText = unlexedText.trimmingPrefix(while: \.isWhitespace)
            } else {
                let token: Token
                let columnNumber = line.distance(from: line.startIndex, to: unlexedText.startIndex) + 1
                if let match = unlexedText.prefixMatch(of: /[a-zA-Z_][a-zA-Z_0-9]*/) {
                    token = switch match.output {
                    case "external":
                        .externalKeyword(atLine: lineNumber, column: columnNumber)
                    case "function":
                        .functionKeyword(atLine: lineNumber, column: columnNumber)
                    case "public":
                        .publicKeyword(atLine: lineNumber, column: columnNumber)
                    case "return":
                        .returnKeyword(atLine: lineNumber, column: columnNumber)
                    default:
                        .identifier(match.output, atLine: lineNumber, column: columnNumber)
                    }
                } else if let match = unlexedText.prefixMatch(
                    of: /0b[01][01_]*|0o[0-7][0-7_]*|0x[0-9a-fA-F][0-9a-fA-F_]*|[0-9][0-9_]*/
                ) {
                    token = .integerLiteral(match.output, atLine: lineNumber, column: columnNumber)
                } else {
                    token = switch character {
                    case "(":
                        .openingParenthesis(atLine: lineNumber, column: columnNumber)
                    case ")":
                        .closingParenthesis(atLine: lineNumber, column: columnNumber)
                    case "<":
                        .openingAngleBracket(atLine: lineNumber, column: columnNumber)
                    case ">":
                        .closingAngleBracket(atLine: lineNumber, column: columnNumber)
                    case "{":
                        .openingBrace(atLine: lineNumber, column: columnNumber)
                    case "}":
                        .closingBrace(atLine: lineNumber, column: columnNumber)
                    case "-" where unlexedText.hasPrefix("->"):
                        .arrow(atLine: lineNumber, column: columnNumber)
                    default:
                        throw .unexpectedCharacter(character, atLine: lineNumber, column: columnNumber)
                    }
                }
                unlexedText = unlexedText.trimmingPrefix(token.description)
                tokens.append(token)
            }
        }
    }
    return tokens
}
