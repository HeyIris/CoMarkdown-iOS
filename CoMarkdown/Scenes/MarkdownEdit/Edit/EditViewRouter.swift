//
//  EditViewRouter.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/18.
//  Copyright © 2018年 Tongji. All rights reserved.
//

import UIKit

protocol EditViewRouter: ViewRouter {
}

class EditViewRouterImplementation : EditViewRouter{
    fileprivate weak var editViewController: EditViewController?
    
    init(editViewController: EditViewController) {
        self.editViewController = editViewController
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
