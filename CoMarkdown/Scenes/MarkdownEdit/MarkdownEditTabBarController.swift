//
//  MarkdownEditTabBarController.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/18.
//  Copyright © 2018年 Tongji. All rights reserved.
//

import UIKit

class MarkdownEditTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func creatSubViewControllers(){
        let v1  = EditViewController()
        let item1 : UITabBarItem = UITabBarItem (title: "Edit", image: UIImage(named: "Edit"), selectedImage: UIImage(named: ""))
        v1.tabBarItem = item1
        
        let v2 = PreviewViewController()
        let item2 : UITabBarItem = UITabBarItem (title: "Preview", image: UIImage(named: "Preview"), selectedImage: UIImage(named: ""))
        v2.tabBarItem = item2
        
        let tabArray = [v1, v2]
        self.viewControllers = tabArray
    }
}
