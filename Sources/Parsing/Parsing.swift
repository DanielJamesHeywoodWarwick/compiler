import Tokens
import Modules

extension Module {
    
    @inlinable
    public init(_ tokens: [Token]) {
        self.init(makeDeclarations: {})
    }
}
