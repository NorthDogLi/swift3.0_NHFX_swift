////
////  JQDic_Model.swift
////  NHFX_swift
////
////  Created by 李家奇_南湖国旅 on 2017/6/20.
////  Copyright © 2017年 李家奇_南湖国旅. All rights reserved.
////
//
//import Foundation
//
////class JQDic_Model: NSObject {
////
////}
//
//@objc public protocol DicModelProtocol {
//    static func customClassMapping() -> [String : String]?
//}
//
//extension NSObject {
//    //要进行转换的字典
//    class func objectWithKeyValues(dic : NSDictionary) ->AnyObject {
//        
//        
//        let objc:AnyObject = self
//        
//        for key in dic.allKeys {
//            
//            let value:AnyObject = dic[key] as AnyObject
//            
//            let property = class_getProperty(NSObject_KeyValues.self,   (key as AnyObject).utf8String)
//            
//            var count: UInt32 = 0
//            
//            var attributeList = objc_property_attribute_t()
//            //15622228230
//            attributeList = class_copyPropertyList(NSObject_KeyValues.self, &count)
//            let attribute = attributeList?[0]
//            let typeString = attribute?.hashValue//[NSString stringWithUTF8String:attribute.value];
//            
//        }
//        
//        
//        return objc
//    }
//}
