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
            let descriptor = try FileDescriptor.open(path, .readOnly)
            return try descriptor.closeAfter {
#if os(Windows)
                let rawByteCount = try descriptor.seek(offset: 0, from: .end)
                try descriptor.seek(offset: 0, from: .start)
#else
                let rawByteCount = try descriptor.stat().size
#endif
                guard let byteCount = Int(exactly: rawByteCount) else {
                    throw StringError(
                        "Expected the file to be smaller than \(Int.max) bytes, but it is \(rawByteCount) bytes"
                    )
                }
                return try withUnsafeTemporaryAllocation(of: UInt8.self, capacity: byteCount) { buffer in
                    var uninitializedBytes = UnsafeMutableRawBufferPointer(buffer)
                    while !uninitializedBytes.isEmpty {
                        let bytesRead = try descriptor.read(into: uninitializedBytes)
                        uninitializedBytes = UnsafeMutableRawBufferPointer(
                            rebasing: uninitializedBytes.dropFirst(bytesRead)
                        )
                    }
                    return String(copying: try UTF8Span(validating: buffer.span))
                }
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
