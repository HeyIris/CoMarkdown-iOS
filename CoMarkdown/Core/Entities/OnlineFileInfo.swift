//
//  OnlineFileInfo.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/19.
//  Copyright © 2018年 Tongji. All rights reserved.
//

import SwiftyJSON

struct OnlineFileInfo {
    var list: [OnlineFileItem]
    
    init(data: JSON) {
        list = [OnlineFileItem]()
        for item in data["list"]{
            list.append(OnlineFileItem(data: item.1))
        }
    }
}
