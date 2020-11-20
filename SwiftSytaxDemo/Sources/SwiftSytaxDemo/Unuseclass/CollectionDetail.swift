//
//  File.swift
//  
//
//  Created by lixu12 on 2020/11/18.
//

import Foundation
import SwiftSyntax

public enum SourceKind {
    case classKind
    case structKind
    case funtionKind
    case protocolKind
    case enumKind
}

public struct SourceLocation{
    
    public let path: String
    
    public let line: Int
    
    public let column: Int
    
    public let offset: Int
}

extension SourceLocation: CustomStringConvertible {
    public var description: String {
        "\(path):\(line):\(column)"
    }
}


public struct SourceDetail{
    
    public let name: String
    
    public let sourceKind: SourceKind
    
    public let location: SourceLocation
    
}

extension SourceDetail: CustomStringConvertible {
    public var description: String {
        "\(name) | \(sourceKind) | \(location.description)"
    }
}
