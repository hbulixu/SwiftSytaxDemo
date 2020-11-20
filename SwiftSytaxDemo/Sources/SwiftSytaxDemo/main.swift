import Path
import SwiftSyntax
print("Hello, world!")


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

func unUseImage(_ path: Path) throws -> Void {
    
    let imagePath = Path("/Users/lixu12/Documents/work/app/huangye_ios/IOS/58BP/Source/");
    var images = try getAllImageInfos(imagePath!);
    
    let files:[Path] = try recursiveFiles(withExtensions: ["swift","h","m","mm"], at: path)
    
    for file in files{
        let sourceFile = try SyntaxParser.parse(file.url)
        let visitor = ImageVisitor(images)
        visitor.walk(sourceFile);
        images = visitor.images;
    }
    
    let xmlFiles:[Path] =  try recursiveFiles(withExtensions: ["xib","storyboard"], at: path)
    
    for xmlFile in xmlFiles {
        let filter = XMLFilter(images);
        filter.filter(xmlFile)
        images = filter.images
    }
    
    for image in images {
        print("\(image.path.basename()) in \(image.path.parent.string)")
    }
}

let path = Path("/Users/lixu12/Documents/work/app/huangye_ios/");



try unUseImage(path!)

//let path = Path("/Users/lixu12/Desktop/SwiftSytaxDemo/SwiftSytaxDemo/Sources/SwiftSytaxDemo/FuncRewriterVisitor.swift")


//let path = Path("/Users/lixu12/Desktop/SwiftSytaxDemo/SwiftSytaxDemo/Sources/SwiftSytaxDemo/test/RewriteTarget.swift")
//
//var files:[Path] = try recursiveFiles(withExtensions: ["swift","h","m","mm"], at: path!)
//
//for file in files{
//
//   try vistor(file);
//  // try injectFunc(file)
//  //  try collection(file)
//}

