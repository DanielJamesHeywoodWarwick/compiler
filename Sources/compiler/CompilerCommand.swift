import ArgumentParser
import SystemPackage

@main
struct CompilerCommand: ParsableCommand {
    
    @Argument(
        help: "The paths to the source files.",
        transform: { string in FilePath(string) }
    )
    var sourcePaths: [FilePath]
    
    static var configuration: CommandConfiguration {
        CommandConfiguration(
            commandName: "compiler",
            abstract: "Compiler for Daniel James Heywood's 3rd year project.",
            version: "0.0.0",
            helpNames: .long
        )
    }
}
