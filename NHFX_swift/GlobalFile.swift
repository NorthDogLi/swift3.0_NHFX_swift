//
//  GlobalFile.swift
//  swift_非同凡享
//
//  Created by 李家奇_南湖国旅 on 2017/6/12.
//  Copyright © 2017年 李家奇_南湖国旅. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage



enum NHGoodsType:Int{
    case NHGoodsType_foreign     //
    case NHGoodsType_todayQG    // 今日抢购
    case NHGoodsType_willQG     // 即将抢购
    case NHGoodsType_Free       // 自由行
    case NHGoodsType_goods      // 商品
}

//MARK: 屏幕设置系列
let SCREEN_WIDTH = UIScreen.main.bounds.size.width

let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let SCREEN_BOUNDS = UIScreen.main.bounds

/** 高度667(6s)为基准比例！！！做到不同屏幕适配高度*/
let NH_HEI =  SCREEN_HEIGHT/667.0

/** 宽度375.0f(6s)为基准比例！！！做到不同屏幕适配宽度  */
let NH_WID =  SCREEN_WIDTH/375.0

let __LEFT = __X(x:12)


/** 适配屏幕宽度比例*f  */
func __X(x:CGFloat) -> CGFloat {
    return NH_WID * x
}

/** 适配屏幕高度比例*f  */
func __Y(y:CGFloat) -> CGFloat {
    return NH_HEI * y
}

func __setCGRECT(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> CGRect {
    return CGRect(x: x, y: y, width: width, height: height)
}

func __setImageName(name:String?) -> UIImage {
    return UIImage(named: name!)!
}




