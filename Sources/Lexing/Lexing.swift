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
                let location = SourceLocation(
                    line: lineNumber,
                    column: line.distance(from: line.startIndex, to: unlexedText.startIndex) + 1
                )
                if let match = unlexedText.prefixMatch(of: /[a-zA-Z_][a-zA-Z_0-9]*/) {
                    token = switch match.output {
                    case "external":
                        .externalKeyword(at: location)
                    case "function":
                        .functionKeyword(at: location)
                    case "private":
                        .privateKeyword(at: location)
                    case "public":
                        .publicKeyword(at: location)
                    case "return":
                        .returnKeyword(at: location)
                    default:
                        .identifier(match.output, at: location)
                    }
                } else if let match = unlexedText.prefixMatch(
                    of: /0b[01][01_]*|0o[0-7][0-7_]*|0x[0-9a-fA-F][0-9a-fA-F_]*|[0-9][0-9_]*/
                ) {
                    token = .integerLiteral(match.output, at: location)
                } else {
                    token = switch character {
                    case "(":
                        .openingParenthesis(at: location)
                    case ")":
                        .closingParenthesis(at: location)
                    case "<":
                        .openingAngleBracket(at: location)
                    case ">":
                        .closingAngleBracket(at: location)
                    case "{":
                        .openingBrace(at: location)
                    case "}":
                        .closingBrace(at: location)
                    case "-" where unlexedText.hasPrefix("->"):
                        .arrow(at: location)
                    default:
                        throw .unexpectedCharacter(character, at: location)
                    }
                }
                unlexedText = unlexedText.trimmingPrefix(token.description)
                tokens.append(token)
            }
        }
    }
    return tokens
}
