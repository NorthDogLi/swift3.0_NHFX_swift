//
//  NHGoodsCell.swift
//  NHFX_swift
//
//  Created by 李家奇_南湖国旅 on 2017/6/14.
//  Copyright © 2017年 李家奇_南湖国旅. All rights reserved.
//

import UIKit


class NHGoodsCell: UITableViewCell {

    //var type : NHGoodsType
    var logs = Catalogs()
    
    var addressLabel = UILabel()//目的地
    var startCityLabel = UILabel()//出发地
    var shareBtn = UIButton()
    
    var titleLabel = UILabel()//标题
    
    var backImage = UIImageView()//图片
    var Remaining = UILabel()//剩余时间
    var priceLabel = UILabel()//现价
    var price_lastLabel = UILabel()//原价
    var yongjin = UILabel()
    
    var lookNumber = UILabel()//查看次数
    var shareNumber = UILabel()//分享次数
    
    let XArray = [CGFloat](arrayLiteral: __LEFT, SCREEN_WIDTH - __LEFT, SCREEN_WIDTH - __LEFT, __LEFT)
    //懒加载
    lazy var lineLayerArray = [CAShapeLayer]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
    }
    

    
    func setUI() {
        
        addSubview(backImage)
        backImage.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(__LEFT)
            make.right.equalTo(-__LEFT)
            make.height.equalTo(__Y(y: 160))
        }
        
        addSubview(shareBtn)
        //shareBtn.backgroundColor = UIColor.yellow
        shareBtn.setImage(__setImageName(name: "首页-B端_44"), for: UIControlState.normal)
        shareBtn.imageEdgeInsets = UIEdgeInsetsMake(__Y(y: 0), __X(x: 20), __Y(y: 30), __X(x: 5))
        shareBtn.addTarget(self, action: #selector(share(_:)), for: UIControlEvents.touchUpInside)
        shareBtn.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.right.equalTo(-__LEFT)
            make.width.height.equalTo(__X(x: 50))
        }
        
        addSubview(addressLabel)
        addressLabel.font = UIFont.systemFont(ofSize: 14)
//        addressLabel.backgroundColor = UIColor.yellow
//        addressLabel.textColor = UIColor.white
        addressLabel.snp.makeConstraints { (make) in
            make.top.equalTo(3)
            make.left.equalTo(__LEFT)
        }
        
        addSubview(startCityLabel)
        startCityLabel.font = UIFont.systemFont(ofSize: 14)
        startCityLabel.backgroundColor = UIColor.black
        startCityLabel.textColor = UIColor.white
        startCityLabel.snp.makeConstraints { (make) in
            make.top.equalTo(3)
            make.left.equalTo(addressLabel.snp.right).offset(__X(x: 10))
        }
        
        addSubview(titleLabel)
        titleLabel.numberOfLines = 2
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(backImage.snp.bottom).offset(__Y(y: 5))
            make.left.equalTo(__X(x: 20))
            make.right.equalTo(-__X(x: 20))
        }
        
        addSubview(priceLabel)
        priceLabel.font = UIFont.systemFont(ofSize: 16)
        priceLabel.text = "现价"
        priceLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-__X(x: 20))
            make.top.equalTo(titleLabel.snp.bottom).offset(__Y(y: 15))
        }
        
        addSubview(price_lastLabel)
        price_lastLabel.font = UIFont.systemFont(ofSize: 14)
        price_lastLabel.text = "原价"
        price_lastLabel.textColor = UIColor.red
        price_lastLabel.snp.makeConstraints { (make) in
            make.top.equalTo(priceLabel)
            make.right.equalTo(priceLabel.snp.left).offset(-__X(x: 12))
        }
        
        addSubview(yongjin)
        yongjin.font = UIFont.systemFont(ofSize: 14)
        yongjin.text = "佣金"
        yongjin.snp.makeConstraints { (make) in
            make.top.equalTo(priceLabel.snp.bottom).offset(__Y(y: 10))
            make.right.equalTo(-__X(x: 20))
        }
        
        addSubview(lookNumber)
        lookNumber.text = "查看"
        lookNumber.snp.makeConstraints { (make) in
            make.left.equalTo(__X(x: 20))
            make.top.equalTo(yongjin)
        }
        
        addSubview(shareNumber)
        shareNumber.text = "分享"
        shareNumber.snp.makeConstraints { (make) in
            make.left.equalTo(lookNumber.snp.right).offset(__X(x: 10))
            make.top.equalTo(lookNumber)
        }
        
        addSubview(Remaining)
        Remaining.font = UIFont.systemFont(ofSize: 16)
        Remaining.text = "剩余"
        Remaining.snp.makeConstraints { (make) in
            make.left.equalTo(__X(x: 20))
            make.top.equalTo(titleLabel.snp.bottom).offset(__Y(y: 15))
        }
    }
    
    //分享
    func share(_:UIButton) {
        
    }
    
    //刷新页面
    func updateCellUI(prods : Products) {
        
        let url = NSURL(string: prods.SelImg!)
        //print("url\(prods.SelImg!)")
        backImage.sd_setImage(with: url as URL?, placeholderImage: __setImageName(name: "FF-logo"))
        
        titleLabel.text = prods.Title
        addressLabel.text = prods.DesCity[0].TagName!
        startCityLabel.text = prods.StartCity[0].TagName!
        //Remaining.text = prods.EndTime!
        priceLabel.text = "现价¥\(prods.Price!)"
        price_lastLabel.text = "原价¥\(prods.PriceOrg!)"
        yongjin.text = "佣金:\(prods.Yongjin!)"
        
        lookNumber.text = "查看:\(prods.StockNum!)"
        shareNumber.text = "分享:\(prods.ShareNum!)"
        
        //边框去除
        for line in lineLayerArray {
            line.removeFromSuperlayer()
        }
        lineLayerArray.removeAll()
        
        
        self.layoutSubviews()
        let height:CGFloat = yongjin.frame.maxY + __Y(y: 20)
        prods.cellHeight = height
        
        
        let YArray = [CGFloat](arrayLiteral: 0.0, 0.0, prods.cellHeight! - 20, prods.cellHeight! - 20)
        
        for i in 0 ... 3 {
            
            let lineLayer = NHTools.shareTool.drawLineLayerWithStartPoint(startPoint: CGPoint(x: XArray[i], y: YArray[i]), endPonint: CGPoint(x: XArray[(i+1)%4], y: YArray[(i+1)%4]), color: UIColor.groupTableViewBackground)
            
            self.layer.addSublayer(lineLayer)
            
            lineLayerArray.append(lineLayer)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
