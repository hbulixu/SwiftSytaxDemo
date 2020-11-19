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
    
    lazy var beforeNode :CodeBlockItemSyntax = {
            let source = "\n print(\"before\");"
            let tree = try! SyntaxParser.parse(source: source)
            return SyntaxFactory.makeCodeBlockItem(item: tree._syntaxNode, semicolon: nil, errorTokens: nil)
    }()
    
    
    lazy var afterNode :CodeBlockItemSyntax = {
            let source = "\n print(\"after\");"
            let tree = try! SyntaxParser.parse(source: source)
            return SyntaxFactory.makeCodeBlockItem(item: tree._syntaxNode, semicolon: nil, errorTokens: nil)
    }()
    
  
    
    override func visit(_ node: FunctionDeclSyntax) -> DeclSyntax {
        
        guard var retBody = node.body else {
            return DeclSyntax(node);
        }
        //防止重复插入
        if(retBody.statements.first?.description == beforeNode.description){
            return DeclSyntax(node);
        }
        retBody.statements = retBody.statements.prepending(beforeNode)
        retBody.statements = retBody.statements.appending(afterNode)
        
        var retNode = FunctionDeclSyntax(node._syntaxNode);
        retNode?.body = retBody;
        return DeclSyntax(retNode!);

    }
    

}
