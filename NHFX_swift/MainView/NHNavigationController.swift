//
//  NHNavigationController.swift
//  swift_非同凡享
//
//  Created by 李家奇_南湖国旅 on 2017/6/9.
//  Copyright © 2017年 李家奇_南湖国旅. All rights reserved.
//

import UIKit

class NHNavigationController: UINavigationController {

    //var supportPortraitOnly:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置导航栏背景颜色
        //self.navigationController?.navigationBar.barTintColor = UIColor.red
        self.navigationBar.barTintColor = UIColor.groupTableViewBackground
        
        let dict:NSDictionary = [NSForegroundColorAttributeName: UIColor.black, NSFontAttributeName : UIFont.systemFont(ofSize: 18)]
        //标题颜色
        self.navigationBar.titleTextAttributes = dict as? [String : AnyObject]
        
    }
    
    //重写父类方法
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        super.pushViewController(viewController, animated: animated)
        
        if (viewController.navigationController?.responds(to: #selector(getter: interactivePopGestureRecognizer)))! {
            
            viewController.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
            viewController.navigationController?.interactivePopGestureRecognizer?.delegate = nil;
        }
        
        if viewController.navigationItem.leftBarButtonItem == nil && self.viewControllers.count > 1{
            
            viewController.navigationItem.leftBarButtonItem = creatBackBtn()
            viewController.navigationItem.leftBarButtonItem?.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }
    
    func creatBackBtn() -> UIBarButtonItem {
        
        return UIBarButtonItem.init(image: UIImage(named:"goback_right"), style: .plain, target: self, action: #selector(popself))
    }
    
    func popself() {
        self.popViewController(animated: true)
    }
    
    
    //重写
//    override func shouldUpdateFocus(in context: UIFocusUpdateContext) -> Bool {
//        
//    }
//    
//    override func shouldAutomaticallyForwardRotationMethods() -> Bool {
//        if (self.supportPortraitOnly) {
//            return false
//        }else{
//            return self.topViewController!.shouldAutorotate
//        }
//    }
    
    
}




