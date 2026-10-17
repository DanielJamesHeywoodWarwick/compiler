import Modules
import Tokens

extension ArraySlice<Token> {
    
    @inlinable
    internal mutating func _parseType() throws(ParsingError) -> Type {
        guard let firstToken = popFirst() else {
            throw .unexpectedEndOfFile(expecting: .type)
        }
        switch firstToken.kind {
        case let .identifier(name):
            return .identifier(name, at: firstToken.location)
        default:
            throw .unexpectedToken(firstToken, expecting: .type)
        }
    }
    
    @inlinable
    internal mutating func _parseExpression() throws(ParsingError) -> Expression {
        guard let firstToken = popFirst() else {
            throw .unexpectedEndOfFile(expecting: .expression)
        }
        switch firstToken.kind {
        case let .integerLiteral(literal):
            return .integerLiteral(literal, at: firstToken.location)
        default:
            throw .unexpectedToken(firstToken, expecting: .expression)
        }
    }
    
    @inlinable
    internal mutating func _parseStatement() throws(ParsingError) -> Statement {
        guard let firstToken = popFirst() else {
            throw .unexpectedEndOfFile(expecting: .statement)
        }
        switch firstToken.kind {
        case .returnKeyword:
            let expression = if let first, ![.returnKeyword, .closingBrace].contains(first.kind) {
                try _parseExpression()
            } else { nil as Expression? }
            return .return(expression, at: firstToken.location)
        default:
            throw .unexpectedToken(firstToken, expecting: .statement)
        }
    }
}
