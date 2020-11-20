//
//  File.swift
//  
//
//  Created by lixu12 on 2020/11/18.
//

import Foundation
import SwiftSyntax

class CollectionVisitor: SyntaxVisitor {
    
    var sources :[SourceDetail] = []
    private let config: CollectionConfig
    
    init(config: CollectionConfig) {
        self.config = config;
    }
    
    ///资源查看
    override func visit(_ node: ClassDeclSyntax) -> SyntaxVisitorContinueKind {
        
        if let position = findLocation(syntax: node.identifier){
            
            sources.append(SourceDetail(name: node.identifier.text, sourceKind: .classKind, location: position))
        }

        return .visitChildren
    }
    
    override func visit(_ node: StructDeclSyntax) -> SyntaxVisitorContinueKind {
        
        if let position = findLocation(syntax: node.identifier){
            
            sources.append(SourceDetail(name: node.identifier.text, sourceKind: .structKind, location: position))
        }
        
        return .visitChildren
    }
    
    override func visit(_ node: FunctionDeclSyntax) -> SyntaxVisitorContinueKind {
        
        print(node.description);
        let ps = node.signature.input.parameterList.compactMap {
            $0.firstName?.text
        }
        let function = Function(name: node.identifier.text, parameters: ps)
        
        if let position = findLocation(syntax: node.identifier){
            
            sources.append(SourceDetail(name: function.description, sourceKind: .funtionKind, location: position))
        }
        
        return .visitChildren
    }
    

    override func visit(_ node: ProtocolDeclSyntax) -> SyntaxVisitorContinueKind {
        
        if let position = findLocation(syntax: node.identifier){
            
            sources.append(SourceDetail(name: node.identifier.text, sourceKind: .protocolKind, location: position))
        }
        return .visitChildren
    }
    
    
    override func visit(_ node: EnumDeclSyntax) -> SyntaxVisitorContinueKind {
        
        if let position = findLocation(syntax: node.identifier){
            
            sources.append(SourceDetail(name: node.identifier.text, sourceKind: .enumKind, location: position))
        }
        return .visitChildren
    }
    
    
}

extension CollectionVisitor{
    
    func findLocation(syntax: SyntaxProtocol) -> SourceLocation? {
        let position = config.locationBuilder.location(for: syntax.positionAfterSkippingLeadingTrivia)
        guard let line = position.line,
            let column = position.column else {
            return nil
        }
        return SourceLocation(path: config.filePath, line: line, column: column, offset: position.offset)
    }

}
