//
//  ViewRouter.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/16.
//  Copyright © 2018年 Tongji. All rights reserved.
//

import UIKit

protocol ViewRouter {
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

extension ViewRouter {
    func prepare(for segue: UIStoryboardSegue, sender: Any?) { }
}
