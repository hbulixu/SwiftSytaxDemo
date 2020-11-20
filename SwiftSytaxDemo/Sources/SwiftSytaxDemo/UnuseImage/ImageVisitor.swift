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

        images = images.filter {
            if(text.contains($0.imageNameWithExt)||text.contains($0.imageNameWithOutX)){
                return false;
            }
            return true;
        }

        return .skipChildren
    }
    
     override  func visit(_ token: TokenSyntax) -> SyntaxVisitorContinueKind {

        switch token.tokenKind {
        case .stringLiteral(let text):
            images = images.filter {
                if(text.contains($0.imageNameWithExt)||text.contains($0.imageNameWithOutX)){
                    return false;
                }
                return true;
            }
        default:
            break
        }
        return .visitChildren
    }
    
}
