//
//  File.swift
//  
//
//  Created by lixu12 on 2020/11/19.
//

import Foundation
import SwiftSyntax


 class ImageVisitor: SyntaxVisitor {
    
    public var images: [ImageInfo] = []
        
    public init(_ images: [ImageInfo]) {
        self.images = images
    }
    
    
     override func visit(_ node: StringSegmentSyntax) -> SyntaxVisitorContinueKind {
        let text = node.content.text
            .trimmingCharacters(in: .whitespacesAndNewlines)
        guard !text.isEmpty else {
            return .skipChildren
        }

        images = images.filter {$0.imageNameWithOutX != text }

        return .skipChildren
    }
    
     override  func visit(_ token: TokenSyntax) -> SyntaxVisitorContinueKind {

        switch token.tokenKind {
        case .stringLiteral(let text):
            images = images.filter { !text.contains($0.imageNameWithOutX) }
        default:
            break
        }
        return .visitChildren
    }
    
}
