//
//  DoOTInfo.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/19.
//  Copyright © 2018年 Tongji. All rights reserved.
//

import SwiftyJSON

struct DoOTInfo {
    var operation: [OperationItem]
    
    init(data: JSON) {
        operation = [OperationItem]()
        for item in data["operation"]{
            operation.append(OperationItem(data: item.1))
        }
    }
}
