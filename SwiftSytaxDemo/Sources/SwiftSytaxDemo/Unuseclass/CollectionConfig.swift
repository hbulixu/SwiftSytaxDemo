//
//  File.swift
//  
//
//  Created by lixu12 on 2020/11/18.
//

import Foundation
import SwiftSyntax

public struct CollectionConfig {
    let filePath: String
    let locationBuilder: SourceLocationConverter
    
    init(filePath:String, sourceFileSytax: SourceFileSyntax) {
        self.filePath = filePath;
        self.locationBuilder = SourceLocationConverter(file: filePath, tree: sourceFileSytax)
    }
}
