//
//  PartakeFileInfo.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/19.
//  Copyright © 2018年 Tongji. All rights reserved.
//

import SwiftyJSON

struct PartakeFileInfo {
    var partake_files: [PartakeFileItem]
    
    init(data: JSON) {
        partake_files = [PartakeFileItem]()
        for item in data["partake_files"]{
            partake_files.append(PartakeFileItem(data: item.1))
        }
    }
}
