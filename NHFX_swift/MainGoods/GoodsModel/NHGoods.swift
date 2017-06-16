//
//  NHGoods.swift
//  swift_非同凡享
//
//  Created by 李家奇_南湖国旅 on 2017/6/13.
//  Copyright © 2017年 李家奇_南湖国旅. All rights reserved.
//

import UIKit
import SwiftyJSON

class NHGoods: NHBaseObject {
    
    //单例创建
    //工具类单例
    static let goods : NHGoods = {
        let good = NHGoods()
        
        return good
    }()
 
    
    var shopID : Int?
    var shop_pic : String?
    var shop_mobile : String?
    var NoPayOrderNum : Int?
    var shopName : String?
    var isLogin : Bool?
    
    var CatalogLis = [CatalogList]()
    var SelectCoutry = [SelectMore]()
    var SelectCitys = [SelectMore]()
    
    
    //MARK:请求相关参数
    var countryid : String?
    var cityid : String?
    
    //MARK: 请求数据 并且解析  闭包回调请求状态
    func loadGoodsSuccess(resultBlock:@escaping(String?)->()) {
        
        let parames:[String : String] = [
                    "countryid":NHGoods.goods.countryid!,
                    "cityid":NHGoods.goods.cityid!,
                    "fromapp":"1"]
        let url = "https://gdapp1032401.nhftfx.com/shop/?fromapp=1"
        
        //请求数据
        NHConnectionManager.shareManager.request(Type: .Post, url: url, parames: parames, succeed: { (suc, value) in
            //清除所有数据
            NHGoods.goods.CatalogLis.removeAll()
            
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
            //设置type
            self.setGoodstype()
            
            //清除空数据
            self.removeNilModel()
            
            //MARK: 回调成功状态
            resultBlock(suc)
            
        }) { (failure) in
            
            //MARK: 回调失败状态
            resultBlock(failure)
        }
    }
    
    
    func assigmentModel(js:JSON) {
        NHGoods.goods.shopID = js["shopID"].int
        NHGoods.goods.shopName = js["shopName"].string
        NHGoods.goods.shop_pic = js["shop_pic"].string
        NHGoods.goods.shop_mobile = js["shop_mobile"].string
        NHGoods.goods.isLogin = js["isLogin"].bool
        NHGoods.goods.NoPayOrderNum = js["NoPayOrderNum"].int
    }
    
    
    func removeNilModel() {
        //倒序排列  不能顺序 否则出错 因为swift数组清除后会向前一位，然后造成数组越界
        //for i in stride(from: NHGoods.goods.CatalogLis.count-1, to: 0, by: -1) {
            //例外一种倒叙写法
        //}
        for i in (0 ... NHGoods.goods.CatalogLis.count-1).reversed() {
            
            if NHGoods.goods.CatalogLis[i].Catalog.count>0 {
                
                let lis = NHGoods.goods.CatalogLis[i]
                
                for j in (0 ... lis.Catalog.count-1).reversed() {
                    
                    for t in (0 ... lis.Catalog[j].products.count-1).reversed() {
                        
                        let title = lis.Catalog[j].products[t].Title
                        //带有测试字样的产品去除
                        if title?.range(of: "测试") != nil {
                            NHGoods.goods.CatalogLis[i].Catalog[j].products.remove(at: t)
                        }
                    }
                    
                    if lis.Catalog[j].products.count == 0 {
                        NHGoods.goods.CatalogLis[i].Catalog.remove(at: j)
                        if lis.Catalog.count == 0 {
                            NHGoods.goods.CatalogLis.remove(at: i)
                        }
                    }
                    
                    let logs = lis.Catalog[j]
                    if lis.type == NHGoodsType.NHGoodsType_todayQG {
                        //今日抢购则全部显示
                        logs.showIndex = logs.products.count
                        
                    }else {//非今日抢购最多显示5个
                        logs.showIndex = logs.products.count > 5 ? 5 : logs.products.count
                    }
                }
                
            }else {
                NHGoods.goods.CatalogLis.remove(at: i)
            }
        }
    }
    
    
    func setGoodstype() {
        for list in NHGoods.goods.CatalogLis {
            
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
}

class CatalogList: NHBaseObject {
    
    var Products : String?
    var CatalogName : String?
    var CatalogType : Int?
    
    var indexSelect : NSInteger?
    var tag : NSInteger?
    
    var type : NHGoodsType?
    
    var Catalog = [Catalogs]()
    
    var cellHeight : CGFloat?//表示每个sectionView的高度
    
    class func assigmentModel(js:JSON) -> CatalogList{
        let List = CatalogList()
        List.CatalogName = js["CatalogName"].string
        List.CatalogType = js["CatalogType"].int
        List.Products = js["CatalogType"].string
        
        List.cellHeight = __Y(y: 40)
        
        return List
    }
}

class Catalogs: NHBaseObject {
    
    var Catalogs2 : String?
    var CatalogName : String?
    var CatalogType : Int?
    
    var showIndex : Int? //表示每个类型显示多少个
    
    var cellHeight : CGFloat?
    
    var products = [Products]()
    
    class func assigmentModel(js:JSON) -> Catalogs{
        let logs = Catalogs()
        logs.CatalogName = js["CatalogName"].string
        logs.CatalogType = js["CatalogType"].int
        
        return logs
    }
}

class Products: NHBaseObject {
    
    var Title : String?
    var ProductUrl : String?
    var StartTime : String?
    var EndTime : String?
    
    var StockTotal : Int?
    var StockNum : Int?
    var ShareNum : Int?
    var ViewNum : Int?
    
    var SelImg : String?
    var PriceOrg : Float?
    var Price : Float?
    var Yongjin : Float?
    
    
    var SmallImg : String?
    var ShareTxt : String?
    var QrImgUrl : String?
    
    var ProductTag = [otherMore]()
    var ProductType = [otherMore]()
    var DesCity = [otherMore]()
    var StartCity = [otherMore]()
    var Country = [otherMore]()
    
    var Imgs_Small = [ImgsMore]()
    var Imgs_NineShare = [ImgsMore]()
    var Imgs_Poster = [ImgsMore]()
    
    var cellHeight : CGFloat?
    
    
    class func assigmentModel(js:JSON) -> Products{
        let prod = Products()
        prod.Title = js["Title"].string
        prod.ProductUrl = js["ProductUrl"].string
        prod.StartTime = js["StartTime"].string
        prod.EndTime = js["EndTime"].string
        
        prod.StockTotal = js["StockTotal"].int
        prod.StockNum = js["StockNum"].int
        prod.ShareNum = js["ShareNum"].int
        
        prod.ViewNum = js["ViewNum"].int
        prod.SelImg = js["SelImg"].string
        prod.PriceOrg = js["PriceOrg"].float
        prod.Price = js["Price"].float
        prod.Yongjin = js["Yongjin"].float
        
        prod.SmallImg = js["SmallImg"].string
        prod.ShareTxt = js["ShareTxt"].string
        prod.QrImgUrl = js["QrImgUrl"].string
        
        prod.cellHeight = __Y(y: 200)//默认赋值
        
        return prod
    }
}

class SelectMore: NHBaseObject {
    
    var TagID : NSInteger?
    var TagName : String?
    
    
    class func assigmentModel(js:JSON) -> SelectMore{
        let Select = SelectMore()
        Select.TagID = js["TagID"].int
        Select.TagName = js["TagName"].string
        
        return Select
    }
}

class otherMore: NHBaseObject {
    
    var TagName : String?
    var TagVal : String?
    
    var TagID : NSInteger?
    var TagType : NSInteger?
    var Sort : NSInteger?
    
    class func assigmentModel(js:JSON) -> otherMore{
        let other = otherMore()
        other.TagName = js["TagName"].string
        other.TagVal = js["TagVal"].string
        
        other.TagID = js["TagID"].int
        other.TagType = js["TagVal"].int
        other.Sort = js["Sort"].int
        
        return other
    }
}

class ImgsMore: NHBaseObject {
    
    var ImgUrl : String?
    var ImgTxt : String?
    
    class func assigmentModel(js:JSON) -> ImgsMore{
        let img = ImgsMore()
        img.ImgUrl = js["ImgUrl"].string
        img.ImgTxt = js["ImgTxt"].string
        
        return img
    }
}




