//
//  NHTools.swift
//  NHFX_swift
//
//  Created by 李家奇_南湖国旅 on 2017/6/14.
//  Copyright © 2017年 李家奇_南湖国旅. All rights reserved.
//

import UIKit

class NHTools: NSObject {
    
    
    //单例创建
    static let shareTool : NHTools = {
        let Tool = NHTools()
        
        return Tool
    }()
    
    /**
     * 指定起始点和终点画线
     */
    func drawLineLayerWithStartPoint(startPoint : CGPoint, endPonint: CGPoint, color : UIColor) -> CAShapeLayer {
        let linePath = UIBezierPath()
        linePath.move(to: startPoint)
        linePath.addLine(to: endPonint)
        linePath.close()
        
        let lineLayer = CAShapeLayer()
        lineLayer.path = linePath.cgPath
        lineLayer.lineWidth = 0.5
        lineLayer.strokeColor = color.cgColor
        
        return lineLayer
    }
    
}
