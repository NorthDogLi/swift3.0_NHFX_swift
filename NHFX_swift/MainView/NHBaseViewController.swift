//
//  NHBaseViewController.swift
//  swift_非同凡享
//
//  Created by 李家奇_南湖国旅 on 2017/6/12.
//  Copyright © 2017年 李家奇_南湖国旅. All rights reserved.
//

import UIKit

class NHBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //跳转调用此方法
    func pushView(controller:UIViewController) {
        self.hidesBottomBarWhenPushed = true;//隐藏tableBar
        self.navigationController?.pushViewController(controller, animated: true)
    }


}
