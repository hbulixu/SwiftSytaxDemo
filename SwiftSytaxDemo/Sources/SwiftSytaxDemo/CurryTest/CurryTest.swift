//
//  File.swift
//  
//
//  Created by lixu12 on 2020/11/23.
//

import Foundation
import Curry

//解决什么问题
//柯里化（Currying），又称部分求值（Partial Evaluation），是一种函数式编程思想，就是把接受多个参数的函数转换成接收一个单一参数（最初函数的第一个参数）的函数，并且返回一个接受余下参数的新函数技术。


func add(a:Int , b:Int) -> Int {
    return a+b;
}

func curryTest(){

  print(curry(add)(2)(3))
}


