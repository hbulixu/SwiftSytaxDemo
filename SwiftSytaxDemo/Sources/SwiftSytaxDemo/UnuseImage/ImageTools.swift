//
//  File.swift
//  
//
//  Created by lixu12 on 2020/11/19.
//

import Foundation
import Path
func getAllImageInfos(_ path:Path) throws ->  [ImageInfo] {
    var imageInfos:[ImageInfo] = []
    let  images: [Path] = try recursiveFiles(withExtensions: ["png", "jpg", "gif"], at: path)
    for imagePath in images {
        
       var  image_x = imagePath.basename(dropExtension: true)
        
       if image_x.hasSuffix("@2x") || image_x.hasSuffix("@3x"){
            image_x = String(image_x.prefix(image_x.count-3))
       }
        
        imageInfos.append(ImageInfo(path: imagePath, imageNameWithOutX: image_x,imageNameWithExt:( "\(image_x).\(imagePath.extension)" )))
    }
    return imageInfos;
}
