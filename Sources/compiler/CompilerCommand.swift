import ArgumentParser

@main
struct CompilerCommand: ParsableCommand {
    
    static var configuration: CommandConfiguration {
        CommandConfiguration(
            commandName: "compiler",
            abstract: "Compiler for Daniel James Heywood's 3rd year project.",
            version: "0.0.0",
            helpNames: .long
        )
    }
}
