//
//  File.swift
//  
//
//  Created by lixu12 on 2020/11/19.
//

import Foundation
import Path

func recursiveFiles(withExtensions exts: [String], at path: Path) throws -> [Path] {
    if path.isFile {
        if exts.contains(path.extension) {
            return [path]
        }
        return []
    } else if path.isDirectory {
        var files: [Path] = []
        for entry in path.ls() {
            let list = try recursiveFiles(withExtensions: exts, at: entry)
            files.append(contentsOf: list)
        }
        return files
    }
    return []
}



