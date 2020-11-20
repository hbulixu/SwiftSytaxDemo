//
//  File.swift
//  
//
//  Created by lixu12 on 2020/11/18.
//


import Foundation

class RewirteTarget {
    
    func test() -> Void {

        print("test");

    }
    
    func test2() -> Void {
        print("test2");
    }
}

func test() -> Void {
    
    RewirteTarget().test2();
}


func test3() -> Void {
    test()
}
