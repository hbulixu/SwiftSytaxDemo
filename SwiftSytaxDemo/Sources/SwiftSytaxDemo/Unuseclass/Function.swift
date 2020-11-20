//
//  File.swift
//  
//
//  Created by lixu12 on 2020/11/19.
//

import Foundation


public struct Function {
    
    /// The name of a function
    public let name: String
    
    /// The parameters of a function
    public let parameters: [String]
}


extension Function: CustomStringConvertible {
    
    public var description: String {
           
        return parameters.reduce("\(name)(") { $0 + "\($1):" } + ")"
    }
}
