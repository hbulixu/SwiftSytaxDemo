//
//  File.swift
//  
//
//  Created by lixu12 on 2020/11/20.
//

import Foundation
import Path

public struct ImageInfo {
    
    let path:Path
    let imageNameWithOutX:String

    init(path:Path,imageNameWithOutX:String) {
        self.path = path;
        self.imageNameWithOutX = imageNameWithOutX;
    }
}
