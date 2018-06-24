//
//  OnlineFileItem.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/19.
//  Copyright © 2018年 Tongji. All rights reserved.
//

import SwiftyJSON

struct OnlineFileItem {
    var name:String
    var id:Int
    
    init(data: JSON) {
        name = data["name"].string!
        id = data["id"].int!
    }
}
