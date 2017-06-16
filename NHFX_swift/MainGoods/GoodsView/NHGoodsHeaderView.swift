//
//  NHGoodsHeaderView.swift
//  swift_非同凡享
//
//  Created by 李家奇_南湖国旅 on 2017/6/12.
//  Copyright © 2017年 李家奇_南湖国旅. All rights reserved.
//

import UIKit


class NHGoodsHeaderView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var addressImage = UIImageView()
    var addressLb = UILabel()
//    var myOrderLb = UILabel()
//    var address = UILabel()
    var backgroupImage = UIImageView()
    var userbackgroupImage = UIImageView()
    var userImage = UIImageView()
    var userID = UILabel()
    var userNameLb = UILabel()
    var userTelLb = UILabel()
    var shareBtn = UIButton()
    
    var mutPlaceBtnAry = [NHPlaceButton]()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: __Y(y: 200))
        
        setGoodsHeaderView()
    }
    
    func setGoodsHeaderView() {
    
        addSubview(backgroupImage);
        backgroupImage.image = UIImage(named: "FF-logo")
        backgroupImage.snp.makeConstraints { (make) in
            make.left.equalTo(__X(x: 12));
            make.width.equalTo(SCREEN_WIDTH-__X(x: 12)*2);
            make.top.equalTo(__Y(y: 20));
            make.height.equalTo(__Y(y: 140));
        }
        
        addSubview(addressImage)
        addressImage.image = UIImage(named: "Location0")
        addressImage.snp.makeConstraints { (make) in
            make.top.equalTo(__Y(y: 15))
            make.left.equalTo(__X(x: 12))
            make.width.equalTo(__X(x: 14));
            make.height.equalTo(__Y(y: 18));
        }
        
        addSubview(addressLb)
        addressLb.textColor = UIColor.black
        addressLb.font = UIFont.systemFont(ofSize: 16)
        addressLb.text = "广州"
        addressLb.snp.makeConstraints { (make) in
            make.top.height.equalTo(addressImage)
            make.left.equalTo(addressImage.snp.right).offset(0)
        }
        
        
        addSubview(userbackgroupImage)
        userbackgroupImage.image = UIImage(named: "nh_home_show_info_bg")
        userbackgroupImage.layer.cornerRadius = __X(x: 5);
        userbackgroupImage.layer.masksToBounds = true;
        userbackgroupImage.snp.makeConstraints { (make) in
            make.left.right.equalTo(backgroupImage)
            make.top.equalTo(backgroupImage.snp.bottom).offset(0)
            make.height.equalTo(__Y(y: 60))
        }
        
        userbackgroupImage.addSubview(userImage)
        userImage.layer.cornerRadius = __X(x: 42/2);
        userImage.layer.masksToBounds = true;
        userImage.image = UIImage(named: "bear")
        userImage.snp.makeConstraints { (make) in
            make.top.equalTo(__Y(y: 10))
            make.left.equalTo(__X(x: 12))
            make.height.width.equalTo(__X(x: 42))
        }
        
        addSubview(userNameLb)
        userNameLb.textColor = UIColor.black
        userNameLb.font = UIFont.systemFont(ofSize: 16)
        userNameLb.text = "欢迎加入swift"
        userNameLb.snp.makeConstraints { (make) in
            make.top.equalTo(userImage)
            make.left.equalTo(userImage.snp.right).offset(5)
            make.height.equalTo(__Y(y: 20))
        }
        
        addSubview(userTelLb)
        userTelLb.textColor = UIColor.red
        userTelLb.font = UIFont.systemFont(ofSize: 14)
        userTelLb.text = "10086"
        userTelLb.snp.makeConstraints { (make) in
            make.top.equalTo(userNameLb.snp.bottom).offset(__Y(y: 5))
            make.left.equalTo(userNameLb)
            make.height.equalTo(__Y(y: 20))
        }
        
        userbackgroupImage.addSubview(shareBtn)
        shareBtn.setImage(UIImage(named: "首页-B端_44"), for: UIControlState.normal)
        shareBtn.imageEdgeInsets = UIEdgeInsetsMake(__Y(y: 12), __X(x: 10), __Y(y: 10), __X(x: 12))
        shareBtn.snp.makeConstraints { (make) in
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.height.width.equalTo(__X(x: 44))
        }
        
        self.layoutIfNeeded()
        
        let height:CGFloat = userbackgroupImage.frame.maxY+__Y(y: 15)
        self.frame.size.height = height
    }
    
    //刷新头部
    func updateHeaderView() {
        userNameLb.text = NHGoods.goods.shopName!
        userTelLb.text = NHGoods.goods.shop_mobile
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: 选择地区按钮
class NHPlaceButton: UIView {
    
    var textLb = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = __X(x: 20)
        
        
        textLb.textColor = .white
        textLb.font = UIFont.systemFont(ofSize: __X(x: 15))
        textLb.textAlignment = .center
        addSubview(textLb)
        
        textLb.snp.makeConstraints { (make) in
            make.left.top.width.height.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
