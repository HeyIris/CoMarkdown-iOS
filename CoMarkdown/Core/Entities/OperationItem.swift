//
//  OperationItem.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/19.
//  Copyright © 2018年 Tongji. All rights reserved.
//

import SwiftyJSON

struct OperationItem {
    var name: String
    var ops: [String]
    
    init(data: JSON) {
        name = data["name"].string!
        ops = [String]()
        for item in (data["ops"].arrayValue.map{ $0.string!}){
            ops.append(item)
        }
    }
}
