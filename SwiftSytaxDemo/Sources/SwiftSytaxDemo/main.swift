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


//let path = Path("/Users/lixu12/Desktop/SwiftSytaxDemo/Sources/SwiftSytaxDemo/test/RewriteTarget.swift")



func vistor(_ file: Path) throws -> Void {
    
    let sourceFile = try SyntaxParser.parse(file.url)
    TestVisitor().walk(sourceFile);
}


func injectFunc(_ file: Path) throws -> Void {
    
    let sourceFile = try SyntaxParser.parse(file.url)
    let beforeStr = """
                    print("before")
                    print("before1")
                    """
    let afterStr = """
                    print("after")
                    print("after1")
                   """
    
    let config = FuncRewriterConfig(filePath: file.description, sourceFileSytax: sourceFile, beforeSource: beforeStr, afterSource: afterStr);
    let content = FuncRewriterVisitor(config: config).visit(sourceFile);
    var fileContents: String = "";
    content.write(to: &fileContents)
    try fileContents.write(to: file.url, atomically: true, encoding: .utf8)
    
}

func collection(_ file: Path) throws -> Void {
    
    let sourceFile = try SyntaxParser.parse(file.url)
    
   let visitor = CollectionVisitor(config: CollectionConfig(filePath: file.description, sourceFileSytax: sourceFile))
    visitor.walk(sourceFile)
    for item in visitor.sources {
        print(item);
    }
    
}


//let path = Path("/Users/lixu12/Desktop/SwiftSytaxDemo/SwiftSytaxDemo/Sources/SwiftSytaxDemo/FuncRewriterVisitor.swift")


let path = Path("/Users/lixu12/Desktop/SwiftSytaxDemo/SwiftSytaxDemo/Sources/SwiftSytaxDemo/test/RewriteTarget.swift")

var files:[Path] = try recursiveFiles(withExtensions: ["swift","h","m","mm"], at: path!)

for file in files{
    
  // try vistor(file);
   try injectFunc(file)
  //  try collection(file)
}

