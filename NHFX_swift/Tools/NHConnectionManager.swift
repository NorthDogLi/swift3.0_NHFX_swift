//
//  NHConnectionManager.swift
//  NHFX_swift
//
//  Created by 李家奇_南湖国旅 on 2017/6/13.
//  Copyright © 2017年 李家奇_南湖国旅. All rights reserved.
//

import UIKit
import Alamofire


enum ConnectionType {
    case Get
    case Post
}


class NHConnectionManager: NSObject {

    //单例创建
    static let shareManager : NHConnectionManager = {
        let manager = NHConnectionManager()
        
        return manager
    }()
    
    //回调成功和失败的 闭包方法
    func request(Type:ConnectionType, url:String, parames:[String:Any], succeed : @escaping(String?, Any?) ->(), failure:@escaping(String?) ->() ) {
        
        Alamofire.request(url, method:.post, parameters:parames).responseJSON { (retultOb) in
            
            switch retultOb.result {
                
            //成功
            case .success:
                
                if let value = retultOb.result.value{
                    // 成功闭包
                    succeed("succeed", value)
                }
                
            //失败
            case .failure:
                
                failure("failure")
            }
            
        }
        
    }
    
    
}
