//
//  File.swift
//  
//
//  Created by lixu12 on 2020/11/18.
//

import Foundation
import SwiftSyntax


//todo:代码格式化
class  FuncRewriterVisitor: SyntaxRewriter {
    
    private let config: FuncRewriterConfig
    private let formBeforeSource: String
    private let formAfterSource: String
    
    init(config: FuncRewriterConfig) {
        self.config = config;
        self.formAfterSource = "\n\(config.afterSource)";
        self.formBeforeSource = "\n\(config.beforeSource)";
    }
    
    lazy var beforeNode :CodeBlockItemSyntax = {
        
        let tree = try! SyntaxParser.parse(source: formBeforeSource)
        return SyntaxFactory.makeCodeBlockItem(item: tree._syntaxNode, semicolon: nil, errorTokens: nil)
    }()
    
    
    lazy var afterNode :CodeBlockItemSyntax = {
        let tree = try! SyntaxParser.parse(source: formAfterSource )
        return SyntaxFactory.makeCodeBlockItem(item: tree._syntaxNode, semicolon: nil, errorTokens: nil)
    }()
        
    override func visit(_ node: FunctionDeclSyntax) -> DeclSyntax {
        
        guard var retBody = node.body else {
            return DeclSyntax(node);
        }
       
        //防止重复插入
        if let firstItem = retBody.statements.first?.description{
            if formBeforeSource.description.range(of: firstItem) != nil{
                return DeclSyntax(node);
            }
        }
        
        retBody.statements = retBody.statements.prepending(beforeNode)
        retBody.statements = retBody.statements.appending(afterNode)
        
        var retNode = FunctionDeclSyntax(node._syntaxNode);
        retNode?.body = retBody;
        return DeclSyntax(retNode!);

    }
    

}

//extension  FuncRewriterVisitor{
//
//    func findColum(syntax: SyntaxProtocol) -> Int {
//        let position = config.locationBuilder.location(for: syntax.positionAfterSkippingLeadingTrivia)
//        return position.column ?? 0;
//    }
//
//    func makeBeforeSource(syntax: SyntaxProtocol) -> CodeBlockItemSyntax {
//
//       int colum = findColum(syntax: syntax);
//        config.beforeSource.compactMap({
//
//        })
//    }
//}
