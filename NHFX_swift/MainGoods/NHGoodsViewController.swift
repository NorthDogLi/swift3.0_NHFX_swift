//
//  NHGoodsViewController.swift
//  swift_非同凡享
//
//  Created by 李家奇_南湖国旅 on 2017/6/9.
//  Copyright © 2017年 李家奇_南湖国旅. All rights reserved.
//

import UIKit
import MJRefresh

private let Identifier = "BaseStrategyCell"

class NHGoodsViewController: NHBaseViewController {
    
    // 顶部刷新
    let header = MJRefreshNormalHeader()
    // 底部刷新
    let footer = MJRefreshAutoNormalFooter()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //隐藏导航栏
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        //是否隐藏tabBar 底部
        self.tabBarController?.tabBar.isHidden = false
        self.hidesBottomBarWhenPushed = false//是否推出底部控制器
        self.tabBarController?.tabBar.isTranslucent = false//不透明
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "商品"
        view.backgroundColor = UIColor.white
        
        setThisUI()
        
        NHTableView.mj_header.beginRefreshing()
    }
    
    //加载数据
    func loadData() {
        NHGoods.goods.cityid = "-1"
        NHGoods.goods.countryid = ""
        NHGoods.goods.loadGoodsSuccess { (result) in
            
            self.NHTableView.mj_header.endRefreshing()
            
            if result! == "succeed" {
                //更新
                self.goodsHeaderview.updateHeaderView()
                
                self.NHTableView.reloadData()
            }
        }
    }
    
    //改变状态栏
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.default
    }
    
    func push() {
        let controller = NHHomeViewController()
        pushView(controller: controller)
    }
    
    func setThisUI() {
        
        view.addSubview(NHTableView)
        
        NHTableView.tableHeaderView = goodsHeaderview
        
        header.setRefreshingTarget(self, refreshingAction: #selector(headerRefresh))
        NHTableView.mj_header = header
        
        //footer.setRefreshingTarget(self, refreshingAction: #selector(footerRefresh))
        //NHTableView.mj_footer = footer
    }
    func headerRefresh() {
        loadData()
    }
    
    func footerRefresh() {
        NHTableView.mj_footer.endRefreshing()
    }
    //懒加载
    lazy var NHTableView:UITableView = {
        
        let NHTableView = UITableView.init(frame: __setCGRECT(x: 0, y: 0, width: SCREEN_WIDTH, height: self.view.frame.size.height-(self.tabBarController?.tabBar.frame.size.height)!), style: UITableViewStyle.grouped)
        NHTableView.delegate = self
        NHTableView.dataSource = self
        NHTableView.backgroundColor = UIColor.white
        //不显示下划线
        NHTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        return NHTableView
    }()
    
    //懒加载头部视图
    lazy var goodsHeaderview : NHGoodsHeaderView = {
        let goodsHeaderview:NHGoodsHeaderView = NHGoodsHeaderView()
        
        return goodsHeaderview
    }()
}


//MARK: 代理
extension NHGoodsViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return NHGoods.goods.CatalogLis.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let list = NHGoods.goods.CatalogLis[section]
        
        return list.Catalog[0].showIndex!
//        return list.Catalog[0].products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell:NHGoodsCell = NHGoodsCell.init(style: UITableViewCellStyle.default, reuseIdentifier: Identifier)
        
        let list = NHGoods.goods.CatalogLis[indexPath.section]
        
        cell.updateCellUI(prods: list.Catalog[0].products[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        let list = NHGoods.goods.CatalogLis[indexPath.section]
        
        return list.Catalog[0].products[indexPath.row].cellHeight!
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let list = NHGoods.goods.CatalogLis[section]
        let sectionView = NHGoodsSectionHeaderView.creatHeaderView(type2: list.type!)
        
        sectionView.updateSectionView(list : list)
        
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if NHGoods.goods.CatalogLis[section].cellHeight! == 0 {
            return __Y(y: 44)
        }else {
            return NHGoods.goods.CatalogLis[section].cellHeight!
        }
    }
    //142
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let list = NHGoods.goods.CatalogLis[section]
        let logs = list.Catalog[0];
        
        if logs.showIndex == logs.products.count {
            return nil
        }else {
            let footView = UIView()
            footView.backgroundColor = UIColor.white
            footView.frame = __setCGRECT(x: 0, y: 0, width: SCREEN_WIDTH, height: __Y(y: 100))
            
            let button = UIButton(type: UIButtonType.custom)
            footView.addSubview(button)

            button.backgroundColor = UIColor.white
            button.frame = __setCGRECT(x: (SCREEN_WIDTH-__X(x: 300))/2, y: __Y(y: 25), width: __X(x: 300), height: __Y(y: 58))
            
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.setTitle("加载更多", for: UIControlState.normal)
            button.setTitleColor(UIColor.red, for: UIControlState.normal)
            button.layer.masksToBounds = true
            button.layer.borderColor = UIColor.red.cgColor
            button.layer.borderWidth = 1.0
            button.layer.cornerRadius = __Y(y: 58)/2
            button.tag = section
            button.addTarget(self, action: #selector(loadMore(btn:)), for: UIControlEvents.touchUpInside)
            
            return footView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let list = NHGoods.goods.CatalogLis[section]
        let logs = list.Catalog[0];
        if logs.showIndex == logs.products.count {
            return 0.1
        }else {
            return __Y(y: 100)
        }
    }
    
    func loadMore(btn : UIButton) {
        let list = NHGoods.goods.CatalogLis[btn.tag]
        
        let logs = list.Catalog[0];
        
        if (logs.showIndex! + 5 > logs.products.count) {
            
            logs.showIndex = logs.products.count;
        }else{
            
            logs.showIndex = logs.showIndex! + 5;
        }
        print("tag==\(btn.tag)")
        NHTableView.reloadSections(NSIndexSet(index:btn.tag) as IndexSet, with: UITableViewRowAnimation.none)
    }
}


