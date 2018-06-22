//
//  PreviewViewRouter.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/18.
//  Copyright © 2018年 Tongji. All rights reserved.
//

import UIKit

protocol PreviewViewRouter: ViewRouter {
}

class PreviewViewRouterImplementation : PreviewViewRouter{
    fileprivate weak var previewViewController: PreviewViewController?
    
    init(previewViewController: PreviewViewController) {
        self.previewViewController = previewViewController
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
