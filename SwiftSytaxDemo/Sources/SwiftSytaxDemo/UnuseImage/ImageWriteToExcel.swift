//
//  File.swift
//  
//
//  Created by lixu12 on 2020/11/23.
//

import Foundation


func writeToExcel(imageInfos : [ImageInfo]) throws -> Void {
    
    var contents:String = ""
    
    for imageInfo in imageInfos {
        contents.append("\(imageInfo.path.basename())\t \(imageInfo.path.parent.string)\n")
    }
    let filePath = "/Users/lixu12/Desktop/SwiftSytaxDemo/UnuseImage.xls"
    try contents.write(toFile: filePath, atomically: true, encoding: .utf16)
}
