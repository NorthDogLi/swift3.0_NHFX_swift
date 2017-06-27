//
//  NHGoods.swift
//  swift_非同凡享
//
//  Created by 李家奇_南湖国旅 on 2017/6/13.
//  Copyright © 2017年 李家奇_南湖国旅. All rights reserved.
//

import UIKit
import SwiftyJSON


class NHGoods: NSObject {
    
    //单例创建
    //工具类单例
    static let goods : NHGoods = {
        let good = NHGoods()
        
        return good
    }()
 
    
    var shopID : Int!
    var shop_pic : String!
    var shop_mobile : String!
    var NoPayOrderNum : Int!
    var shopName : String!
    var isLogin : Bool!
    
    var CatalogList = [CatalogLis]()
    var SelectCoutry = [SelectMore]()
    var SelectCitys = [SelectMore]()
    
    
    //MARK:请求相关参数
    var countryid : String!
    var cityid : String!
    
    //MARK: 请求数据 并且解析  闭包回调请求状态
    func loadGoodsSuccess(resultBlock:@escaping(String?)->()) {
        
        let parames:[String : String] = [
                    "countryid":NHGoods.goods.countryid,
                    "cityid":NHGoods.goods.cityid,
                    "fromapp":"1"]
        let url = "https://gdapp1032401.nhftfx.com/shop/?fromapp=1"
        
        //请求数据
        NHConnectionManager.shareManager.request(Type: .Post, url: url, parames: parames as [String : AnyObject], succeed: { (suc, value) in
            //清除所有数据
            NHGoods.goods.CatalogList.removeAll()
            
            let god = NHGoods.model(withJSON: value as AnyObject)
            
            god?.assigmentProperty(goods: god!)
            
            //清除空数据
            god?.removeNilModel()
            
            //设置type
            god?.setGoodstype()
            
            //MARK: 回调成功状态
            resultBlock(suc)
            
        }) { (failure) in
            
            //MARK: 回调失败状态
            resultBlock(failure)
        }
    }
    
    func assigmentProperty(goods:NHGoods) {
        NHGoods.goods.shopID = goods.shopID
        NHGoods.goods.shop_pic = goods.shop_pic
        NHGoods.goods.shop_mobile = goods.shop_mobile
        NHGoods.goods.NoPayOrderNum = goods.NoPayOrderNum
        NHGoods.goods.shopName = goods.shopName
        NHGoods.goods.isLogin = goods.isLogin
        NHGoods.goods.CatalogList = goods.CatalogList
        NHGoods.goods.SelectCoutry = goods.SelectCoutry
        NHGoods.goods.SelectCitys = goods.SelectCitys
    }
    
    func removeNilModel() {
        //倒序排列  不能顺序 否则出错 因为swift数组清除后会向前一位，然后造成数组越界
        //for i in stride(from: NHGoods.goods.CatalogLis.count-1, to: 0, by: -1) {
            //例外一种倒叙写法
        //}
//        for (index, value) in NHGoods.goods.CatalogLis.enumerated() {
//            
//        }
        for i in (0 ... NHGoods.goods.CatalogList.count-1).reversed() {
            
            if NHGoods.goods.CatalogList[i].Catalogs.count>0 {
                
                let lis = NHGoods.goods.CatalogList[i]
                
                for j in (0 ... lis.Catalogs.count-1).reversed() {
                    
                    for t in (0 ... lis.Catalogs[j].Products.count-1).reversed() {
                        
                        let title = lis.Catalogs[j].Products[t].Title
                        //带有测试字样的产品去除
                        if title?.range(of: "测试") != nil {
                            NHGoods.goods.CatalogList[i].Catalogs[j].Products.remove(at: t)
                        }
                    }
                    
                    if lis.Catalogs[j].Products.count == 0 {
                        NHGoods.goods.CatalogList[i].Catalogs.remove(at: j)
                    }
                    if lis.Catalogs.count == 0 {
                        NHGoods.goods.CatalogList.remove(at: i)
                    }else {
                        //print(lis.Catalogs[j])
                        let logs = lis.Catalogs[j]
                        if lis.type == NHGoodsType.NHGoodsType_todayQG {
                            //今日抢购则全部显示
                            logs.showIndex = logs.Products.count
                            
                        }else {//非今日抢购最多显示5个
                            logs.showIndex = logs.Products.count > 5 ? 5 : logs.Products.count
                        }
                    }
                }
                
            }else {
                NHGoods.goods.CatalogList.remove(at: i)
            }
        }
    }
    
    
    func setGoodstype() {
        for list:CatalogLis in NHGoods.goods.CatalogList {
            
            if list.CatalogName!.range(of: "今日抢购") != nil {
                list.type = NHGoodsType.NHGoodsType_todayQG
                
            }else if list.CatalogName!.range(of: "出境长线") != nil {
                list.type = NHGoodsType.NHGoodsType_foreign
                
            }else if list.CatalogName!.range(of: "即将开抢") != nil {
                list.type = NHGoodsType.NHGoodsType_willQG
                
            }else if list.CatalogName!.range(of: "自由行") != nil {
                list.type = NHGoodsType.NHGoodsType_Free
                
            }else if list.CatalogName!.range(of: "跨境商品") != nil {
                list.type = NHGoodsType.NHGoodsType_goods
                
            }else {
                list.type = NHGoodsType.NHGoodsType_foreign;
            }
        }
    }
    
    static func modelContainerPropertyGenericClass() -> [String : AnyObject]? {
        return ["CatalogList"    : CatalogLis.self,
                "SelectCoutry"  : SelectMore.self,
                "SelectCitys"   : SelectMore.self,
                "Catalogs"      : Catalog.self,
                "Products"      : Product.self,
                "ProductType"   : otherMore.self,
                "DesCity"       : otherMore.self,
                "StartCity"     : otherMore.self,
                "Country"       : otherMore.self,
                "ProductTag"    : otherMore.self]
    }
    
}

class CatalogLis: NSObject {
    
    var Products : String!
    var CatalogName : String!
    var CatalogType : NHGoodsType!
    
    var indexSelect : NSInteger!
    var tag : NSInteger!
    
    var type : NHGoodsType!
    
    var Catalogs = [Catalog]()
    
    var cellHeight : CGFloat = 0.0//表示每个sectionView的高度
    
    
    static func modelContainerPropertyGenericClass() -> [String : AnyObject]? {
        return ["Catalogs"      : Catalog.self]
    }
}

class Catalog: NSObject {
    
    var Catalogs2 : String!
    var CatalogName : String!
    var CatalogType : Int!
    
    var showIndex : Int! //表示每个类型显示多少个
    
    var cellHeight : CGFloat = 0.0 
    
    var Products = [Product]()
    
    
    static func modelContainerPropertyGenericClass() -> [String : AnyObject]? {
        return ["Products"      : Product.self]
    }
}

class Product: NSObject {
    
    var Title : String!
    var ProductUrl : String!
    var StartTime : String!
    var EndTime : String!
    
    var StockTotal : String!
    var StockNum : String!
    var ShareNum : String!
    var ViewNum : String!
    
    var SelImg : String!
    var PriceOrg : String!
    var Price : String!
    var Yongjin : String!
    
    
    var SmallImg : String!
    var ShareTxt : String!
    var QrImgUrl : String!
    
    var ProductTag = [otherMore]()
    var ProductType = [otherMore]()
    var DesCity = [otherMore]()
    var StartCity = [otherMore]()
    var Country = [otherMore]()
    
    var Imgs_Small = [ImgsMore]()
    var Imgs_NineShare = [ImgsMore]()
    var Imgs_Poster = [ImgsMore]()
    
    var cellHeight : CGFloat = 0.0
    
    
    static func modelContainerPropertyGenericClass() -> [String : AnyObject]? {
        return ["ProductTag"   : otherMore.self,
                "ProductType"   : otherMore.self,
                "DesCity"       : otherMore.self,
                "StartCity"     : otherMore.self,
                "Country"       : otherMore.self,
                "Imgs_Small"    : ImgsMore.self,
                "Imgs_NineShare"    : ImgsMore.self,
                "Imgs_Poster"    : ImgsMore.self]
    }
}

class SelectMore: NSObject {
    
    var TagID : NSInteger!
    var TagName : String!
    
}

class otherMore: NSObject {
    
    var TagName : String!
    var TagVal : String!
    
    var TagID : NSInteger!
    var TagType : NSInteger!
    var Sort : NSInteger!
    
}

class ImgsMore: NSObject {
    
    var ImgUrl : String!
    var ImgTxt : String!

}


/**
 
 let js = JSON(value!)
 
 //开始解析数据->存储。。。swift没有找到字典转模型，暂时用暴力破解
 self.assigmentModel(js: js)
 
 for (_,Json):(String, JSON) in js["SelectCitys"] {
 let citys:SelectMore = SelectMore.assigmentModel(js: Json)
 //添加全部的城市
 NHGoods.goods.SelectCitys.append(citys)
 }
 
 for (_,Json):(String, JSON) in js["SelectCoutry"] {
 let Coutry:SelectMore = SelectMore.assigmentModel(js: Json)
 //添加全部的地区
 NHGoods.goods.SelectCoutry.append(Coutry)
 }
 
 for (i,Json1):(String, JSON) in js["CatalogList"] {
 
 let cataLis = CatalogList.assigmentModel(js: Json1)
 NHGoods.goods.CatalogLis.append(cataLis)
 
 for (j,Json2):(String, JSON) in Json1["Catalogs"] {
 let cataLogs = Catalogs.assigmentModel(js: Json2)
 //添加
 NHGoods.goods.CatalogLis[Int(i)!].Catalog.append(cataLogs)
 
 for (t,Json3):(String, JSON) in Json2["Products"] {
 let produs = Products.assigmentModel(js: Json3)
 NHGoods.goods.CatalogLis[Int(i)!].Catalog[Int(j)!].products.append(produs)
 
 //img
 for (_,Json4):(String, JSON) in Json3["Imgs_Small"] {
 let img = ImgsMore.assigmentModel(js: Json4)
 NHGoods.goods.CatalogLis[Int(i)!].Catalog[Int(j)!].products[Int(t)!].Imgs_Small.append(img)
 }
 for (_,Json4):(String, JSON) in Json3["Imgs_NineShare"] {
 let img = ImgsMore.assigmentModel(js: Json4)
 NHGoods.goods.CatalogLis[Int(i)!].Catalog[Int(j)!].products[Int(t)!].Imgs_NineShare.append(img)
 }
 for (_,Json4):(String, JSON) in Json3["Imgs_Poster"] {
 let img = ImgsMore.assigmentModel(js: Json4)
 NHGoods.goods.CatalogLis[Int(i)!].Catalog[Int(j)!].products[Int(t)!].Imgs_Poster.append(img)
 }
 
 //other
 for (_,Json4):(String, JSON) in Json3["Country"] {
 let other = otherMore.assigmentModel(js: Json4)
 NHGoods.goods.CatalogLis[Int(i)!].Catalog[Int(j)!].products[Int(t)!].Country.append(other)
 }
 for (_,Json4):(String, JSON) in Json3["StartCity"] {
 let other = otherMore.assigmentModel(js: Json4)
 NHGoods.goods.CatalogLis[Int(i)!].Catalog[Int(j)!].products[Int(t)!].StartCity.append(other)
 }
 for (_,Json4):(String, JSON) in Json3["DesCity"] {
 let other = otherMore.assigmentModel(js: Json4)
 NHGoods.goods.CatalogLis[Int(i)!].Catalog[Int(j)!].products[Int(t)!].DesCity.append(other)
 }
 for (_,Json4):(String, JSON) in Json3["ProductType"] {
 let other = otherMore.assigmentModel(js: Json4)
 NHGoods.goods.CatalogLis[Int(i)!].Catalog[Int(j)!].products[Int(t)!].ProductType.append(other)
 }
 for (_,Json4):(String, JSON) in Json3["ProductTag"] {
 let other = otherMore.assigmentModel(js: Json4)
 NHGoods.goods.CatalogLis[Int(i)!].Catalog[Int(j)!].products[Int(t)!].ProductTag.append(other)
 }
 }
 }
 }
*/

