@inlinable
public func tokens(for text: String) throws(LexingError) -> [Token] {
    var tokens = [] as [Token]
    var unlexedText = Substring(text)
    var position = (lineNumber: 1, columnNumber: 1)
    while !unlexedText.isEmpty {
        if let match = unlexedText.prefixMatch(of: /\R+/) {
            unlexedText = unlexedText.suffix(from: match.endIndex)
            position.lineNumber += match.count
            position.columnNumber = 1
        } else if let match = unlexedText.prefixMatch(of: /\h+/) {
            unlexedText = unlexedText.suffix(from: match.endIndex)
            position.columnNumber += match.count
        } else if unlexedText.hasPrefix("//") {
            guard let match = unlexedText.firstMatch(of: /\R+/) else {
                throw ._unterminatedMultilineComment(atLine: position.lineNumber, column: position.columnNumber)
            }
            unlexedText = unlexedText.suffix(from: match.endIndex)
            position.lineNumber += match.count
            position.columnNumber = 1
        } else if unlexedText.hasPrefix("/*") {
        } else if unlexedText.hasPrefix("*/") {
            throw ._unexpectedMultilineCommentTerminator(atLine: position.lineNumber, column: position.columnNumber)
        } else {
            let token: Token
            if let match = unlexedText.prefixMatch(of: /[a-zA-Z_][a-zA-Z_0-9]*/) {
                token = switch match.output {
                case "external":
                    ._externalKeyword(atLine: position.lineNumber, column: position.columnNumber)
                case "function":
                    ._functionKeyword(atLine: position.lineNumber, column: position.columnNumber)
                case "public":
                    ._publicKeyword(atLine: position.lineNumber, column: position.columnNumber)
                case "return":
                    ._returnKeyword(atLine: position.lineNumber, column: position.columnNumber)
                default:
                    ._identifier(match.output, atLine: position.lineNumber, column: position.columnNumber)
                }
                unlexedText = unlexedText.suffix(from: match.endIndex)
                position.columnNumber += match.count
            } else if let match = unlexedText.prefixMatch(
                of: /0b[01][01_]*|0o[0-7][0-7_]*|0x[0-9a-fA-F][0-9a-fA-F_]*|[0-9][0-9_]*/
            ) {
                token = ._integerLiteral(match.output, atLine: position.lineNumber, column: position.columnNumber)
                unlexedText = unlexedText.suffix(from: match.endIndex)
                position.columnNumber += match.count
            } else if unlexedText.hasPrefix("->") {
                token = ._arrow(atLine: position.lineNumber, column: position.columnNumber)
                unlexedText = unlexedText.dropFirst(2)
                position.columnNumber += 2
            } else {
                token = switch unlexedText.first.unsafelyUnwrapped {
                case "(":
                    ._openingParenthesis(atLine: position.lineNumber, column: position.columnNumber)
                case ")":
                    ._closingParenthesis(atLine: position.lineNumber, column: position.columnNumber)
                case "<":
                    ._openingAngleBracket(atLine: position.lineNumber, column: position.columnNumber)
                case ">":
                    ._closingAngleBracket(atLine: position.lineNumber, column: position.columnNumber)
                case "{":
                    ._openingBrace(atLine: position.lineNumber, column: position.columnNumber)
                case "}":
                    ._closingBrace(atLine: position.lineNumber, column: position.columnNumber)
                default:
                    throw ._unexpectedCharacter(
                        unlexedText.first.unsafelyUnwrapped,
                        atLine: position.lineNumber, column: position.columnNumber
                    )
                }
                unlexedText = unlexedText.dropFirst()
                position.columnNumber += 1
            }
            tokens.append(token)
        }
    }
    return tokens
}
