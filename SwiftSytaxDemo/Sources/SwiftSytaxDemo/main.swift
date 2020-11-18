import Path
import SwiftSyntax
print("Hello, world!")


func recursiveFiles(withExtensions exts: [String], at path: Path) throws -> [Path] {
    if path.isFile {
        if exts.contains(path.extension) {
            return [path]
        }
        return []
    } else if path.isDirectory {
        var files: [Path] = []
        for entry in path.ls() {
            let list = try recursiveFiles(withExtensions: exts, at: entry)
            files.append(contentsOf: list)
        }
        return files
    }
    return []
}

//guard CommandLine.arguments.count > 1, let path = Path(CommandLine.arguments[1]) else {
//    fatalError("You should provide a folder")
//}


let path = Path("/Users/lixu12/Desktop/SwiftSytaxDemo/Sources/SwiftSytaxDemo/test/RewriteTarget.swift")


var files:[Path] = try recursiveFiles(withExtensions: ["swift","h","m","mm"], at: path!)

for file in files{
    
    let sourceFile = try SyntaxParser.parse(file.url)
    //TestVisitor().walk(sourceFile);
    let content = FuncRewriterVisitor().visit(sourceFile);
    var fileContents: String = "";
    content.write(to: &fileContents)
    try fileContents.write(to: file.url, atomically: true, encoding: .utf8)
}


