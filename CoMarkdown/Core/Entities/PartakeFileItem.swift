//
//  PartakeFileItem.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/19.
//  Copyright © 2018年 Tongji. All rights reserved.
//

import SwiftyJSON

struct PartakeFileItem {
    var master:String
    var name:String
    var id:Int
    
    init(data: JSON) {
        master = data["master"].string!
        name = data["name"].string!
        id = data["id"].int!
    }
    
    init() {
        master = ""
        name = ""
        id = -1
    }
}
