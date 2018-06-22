//
//  RegisterInfo.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/19.
//  Copyright © 2018年 Tongji. All rights reserved.
//

import SwiftyJSON

struct RegisterInfo: Codable {
    var success: String
    
    init(json: JSON) {
        if(json["success"].string == nil || json["success"].string != "true"){
            self.success = "false"
            return
        }
        self.success = "true"
    }
}
