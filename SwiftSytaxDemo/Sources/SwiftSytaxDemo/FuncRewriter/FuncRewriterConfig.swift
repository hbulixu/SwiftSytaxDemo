//
//  File.swift
//  
//
//  Created by lixu12 on 2020/11/19.
//

import Foundation
import SwiftSyntax

public struct FuncRewriterConfig{
    
    let filePath: String
    let locationBuilder: SourceLocationConverter
    let beforeSource: String
    let afterSource: String
    
    init(filePath:String, sourceFileSytax: SourceFileSyntax, beforeSource: String,afterSource: String) {
        self.filePath = filePath;
        self.locationBuilder = SourceLocationConverter(file: filePath, tree: sourceFileSytax)
        self.beforeSource = beforeSource
        self.afterSource = afterSource
    }
    
}
