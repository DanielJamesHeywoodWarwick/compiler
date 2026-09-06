import ArgumentParser
import SystemPackage

@main
struct CompilerCommand: ParsableCommand {
    
    @Argument(help: "The paths to the source files.", transform: { string in FilePath(string) })
    var sourcePaths: [FilePath]
    
    func run() throws {
        precondition(
            sourcePaths.allSatisfy { path in path.extension == "source" },
            "Expected validated source files to have extension 'source'"
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
                            uninitializedBytes = UnsafeMutableRawBufferPointer(
                                rebasing: uninitializedBytes.dropFirst(bytesRead)
                            )
                        }
                        do throws(UTF8.ValidationError) {
                            return String(copying: try UTF8Span(validating: buffer.span))
                        } catch {
                            let message: String?
                            switch error.kind {
                            case .invalidNonSurrogateCodePointByte:
                                message = "Invalid non-surrogate code point byte"
                            case .overlongEncodingByte:
                                message = "Overlong encoding byte"
                            case .surrogateCodePointByte:
                                message = "Surrogate code point byte"
                            case .truncatedScalar:
                                message = "Truncated scalar"
                            case .unexpectedContinuationByte:
                                message = "Unexpected continuation byte"
                            default:
                                fatalError()
                            }
                            throw StringError("UTF-8 validation failed\(message.map { message in ": \(message)" } ?? "")")
                        }
                    }
                }
            } catch {
                throw StringError("Failed to read '\(path)': \(error)")
            }
        }
    }
    
    func validate() throws {
        for path in sourcePaths {
            guard let `extension` = path.extension else {
                throw ValidationError(
                    "Expected '\(path)' to have extension 'source', but it has no extension"
                )
            }
            guard `extension` == "source" else {
                throw ValidationError(
                    "Expected '\(path)' to have extension 'source', but it has extension '\(`extension`)'"
                )
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
