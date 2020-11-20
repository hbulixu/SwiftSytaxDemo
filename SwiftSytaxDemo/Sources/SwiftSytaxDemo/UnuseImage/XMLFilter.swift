//
//  File.swift
//  
//
//  Created by lixu12 on 2020/11/20.
//

import Foundation
import Path
public class XMLFilter:NSObject{
    
    public var images : [ImageInfo] = []
    
    init(_ images:[ImageInfo]) {
        self.images = images;
    }
    
    public func filter(_ file:Path) {
        
        guard let xmlParser = XMLParser(contentsOf: file.url) else {
            return;
        }
        xmlParser.delegate = self;
        xmlParser.parse();
    }
    
}


extension XMLFilter:XMLParserDelegate{
    
  public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if  let text = attributeDict["image"]{
            
            images = images.filter { $0.imageNameWithOutX != text }
        }
    }
}
