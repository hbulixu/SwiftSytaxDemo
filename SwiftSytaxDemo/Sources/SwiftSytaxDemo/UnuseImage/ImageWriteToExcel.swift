//
//  File.swift
//  
//
//  Created by lixu12 on 2020/11/23.
//

import Foundation
import Path

func writeToExcel(imageInfos : [ImageInfo], path : Path) throws -> Void {
    
    var contents:String = ""
    
    for imageInfo in imageInfos {
        contents.append("\(imageInfo.path.basename())\t \(imageInfo.path.parent.string)\n")
    }
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = .short
    dateFormatter.dateStyle = .medium
    dateFormatter.locale = Locale.current
    dateFormatter.dateFormat = "Y-MM-dd-HH:mm:ss"
    
    let filePath = "\(path.string)/unuse_image_\(dateFormatter.string(from: Date())).xls"
    
    try contents.write(toFile: filePath, atomically: true, encoding: .utf16)
}
