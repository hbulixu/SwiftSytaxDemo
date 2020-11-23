//
//  File.swift
//  
//
//  Created by lixu12 on 2020/11/18.
//


import Foundation

class RewirteTarget {
    
    func test() -> Void {
print("before")
print("before1")

        print("test");
 print("after")
 print("after1")

    }
    
    func test2() -> Void {
print("before")
print("before1")
        print("test2");
 print("after")
 print("after1")
    }
}

func test() -> Void {
print("before")
print("before1")
    
    RewirteTarget().test2();
 print("after")
 print("after1")
}


func test3() -> Void {
print("before")
print("before1")
    test()
 print("after")
 print("after1")
}

let block = {(params:String)->() in
    print("block")
}
