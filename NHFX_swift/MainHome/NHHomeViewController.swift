//
//  NHHomeViewController.swift
//  swift_非同凡享
//
//  Created by 李家奇_南湖国旅 on 2017/6/9.
//  Copyright © 2017年 李家奇_南湖国旅. All rights reserved.
//

import UIKit

class NHHomeViewController: NHBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "个人"
        view.backgroundColor = UIColor.white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //隐藏导航栏
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        //显示tabBar 底部
        self.tabBarController?.tabBar.isHidden = false
        self.hidesBottomBarWhenPushed = false//是否推出底部控制器
        self.tabBarController?.tabBar.isTranslucent = false//不透明
    }
    
    //改变状态栏
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    func push() {
        
    }
    

}
