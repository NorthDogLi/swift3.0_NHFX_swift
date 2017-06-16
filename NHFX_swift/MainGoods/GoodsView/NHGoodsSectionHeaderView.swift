//
//  NHGoodsSectionHeaderView.swift
//  NHFX_swift
//
//  Created by 李家奇_南湖国旅 on 2017/6/15.
//  Copyright © 2017年 李家奇_南湖国旅. All rights reserved.
//

import UIKit

class NHGoodsSectionHeaderView: UIView {

    
    var titleLabel = UILabel()
    var lineLabel = UILabel()
    var CatalogName = UILabel()
    
 
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    class func creatHeaderView(type2 : NHGoodsType) -> NHGoodsSectionHeaderView{
        
        let header = NHGoodsSectionHeaderView()
        
        header.creatUI(type: type2)
        
        return header
    }
    
    
    func updateSectionView(list : CatalogList) {
        
        titleLabel.text = list.CatalogName
        
        CatalogName.text = list.Catalog[0].CatalogName
        
        self.layoutIfNeeded()
        let height:CGFloat = CatalogName.frame.maxY
        
        list.cellHeight = height
    }
    
    func creatUI(type : NHGoodsType) {
        
        addSubview(titleLabel)
        titleLabel.font = UIFont.systemFont(ofSize: 22)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(__Y(y: 5))
        }
        
        addSubview(lineLabel)
        lineLabel.backgroundColor = UIColor.red
        lineLabel.layer.masksToBounds = true
        lineLabel.layer.cornerRadius = __Y(y: 4)
        lineLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(__Y(y: 5))
            make.centerX.equalTo(self)
            make.width.equalTo(__X(x: 50))
            make.height.equalTo(__Y(y: 3))
        }
        
        
        if type != NHGoodsType.NHGoodsType_todayQG {
            
            addSubview(CatalogName)
            CatalogName.font = UIFont.systemFont(ofSize: 14)
            CatalogName.textColor = UIColor.red
            CatalogName.snp.makeConstraints { (make) in
                make.top.equalTo(titleLabel.snp.bottom).offset(-__Y(y: 5))
                make.left.equalTo(__LEFT)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
