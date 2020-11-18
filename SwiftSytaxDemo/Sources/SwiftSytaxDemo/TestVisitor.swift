//
//  File.swift
//  
//
//  Created by lixu12 on 2020/11/17.
//


import SwiftSyntax
import Path

public class TestVisitor :SyntaxAnyVisitor{
    
    open override func visitAny(_ node: Syntax) -> SyntaxVisitorContinueKind {
        print(node.syntaxNodeType,"-----------------",node.description);
        return .visitChildren
    }
    
}




