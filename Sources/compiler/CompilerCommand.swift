import ArgumentParser
import SystemPackage
import Lexing

@main
struct CompilerCommand: ParsableCommand {
    
    @Argument(help: "The paths to the source files.", transform: { argument in FilePath(argument) })
    var sourcePaths: [FilePath]
    
    @Flag(help: "Print tokens to standard output.")
    var printTokens = false
    
    func run() throws {
        precondition(
            sourcePaths.allSatisfy { path in path.extension == "source" },
            "Expected the validated source files to have extension \"source\""
        )
        let contentsOfSourceFiles = try sourcePaths.map { path in
            do {
                let descriptor = try FileDescriptor.open(path, .readOnly)
                return try descriptor.closeAfter {
#if os(Windows)
                    let rawByteCount = try descriptor.seek(offset: 0, from: .end)
                    try descriptor.seek(offset: 0, from: .start)
#else
                    let rawByteCount = try descriptor.stat().size
#endif
                    guard let byteCount = Int(exactly: rawByteCount) else {
                        throw StringError("File is larger than \(Int.max) bytes")
                    }
                    return try withUnsafeTemporaryAllocation(of: UInt8.self, capacity: byteCount) { buffer in
                        var uninitializedBytes = UnsafeMutableRawBufferPointer(buffer)
                        while !uninitializedBytes.isEmpty {
                            let bytesRead = try descriptor.read(into: uninitializedBytes)
                            uninitializedBytes = UnsafeMutableRawBufferPointer(rebasing: uninitializedBytes.dropFirst(bytesRead))
                        }
                        do throws(UTF8.ValidationError) {
                            return String(copying: try UTF8Span(validating: buffer.span))
                        } catch {
                            let message = switch error.kind {
                            case .invalidNonSurrogateCodePointByte:
                                "Invalid non-surrogate code point byte"
                            case .overlongEncodingByte:
                                "Overlong encoding byte"
                            case .surrogateCodePointByte:
                                "Surrogate code point byte"
                            case .truncatedScalar:
                                "Truncated scalar"
                            case .unexpectedContinuationByte:
                                "Unexpected continuation byte"
                            default:
                                nil as String?
                            }
                            throw StringError("UTF-8 validation failed\(message.map { message in ": \(message)" } ?? "")")
                        }
                    }
                }
            } catch {
                throw StringError("Failed to read '\(path)': \(error)")
            }
        }
        let tokensForSourceFiles = try zip(sourcePaths, contentsOfSourceFiles).map { path, contents in
            do {
                return try tokens(for: contents)
            } catch {
                throw StringError("\(error) of '\(path)'")
            }
        }
        if printTokens {
            for (path, tokens) in zip(sourcePaths, tokensForSourceFiles) {
                print("Tokens for '\(path)':")
                for token in tokens {
                    let kindDescription = switch token.kind {
                    case .identifier:
                        "Identifier"
                    case .externalKeyword, .functionKeyword, .publicKeyword, .returnKeyword:
                        "Keyword"
                    case .integerLiteral:
                        "Integer literal"
                    case .openingParenthesis:
                        "Opening parenthesis"
                    case .closingParenthesis:
                        "Closing parenthesis"
                    case .openingBrace:
                        "Opening brace"
                    case .closingBrace:
                        "Closing brace"
                    case .arrow:
                        "Arrow"
                    }
                    print("  \(kindDescription) '\(token)' at line \(token.location.line), column \(token.location.column)")
                }
                print()
            }
        }
    }
    
    func validate() throws {
        for path in sourcePaths {
            guard let `extension` = path.extension else {
                throw ValidationError("Expected '\(path)' to have extension 'source', but it has no extension")
            }
            guard `extension` == "source" else {
                throw ValidationError("Expected '\(path)' to have extension 'source', but it has extension '\(`extension`)'")
            }
        }
    }
    
    static var configuration: CommandConfiguration {
        CommandConfiguration(
            commandName: "compiler",
            abstract: "Compiler for Daniel James Heywood's 3rd year project.",
            version: "0.0.0",
            helpNames: .long
        )
    }
}

struct StringError: Error, CustomStringConvertible {
    
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
    
    var description: String { message }
}
