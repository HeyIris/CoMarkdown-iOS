//
//  LoginInfo.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/19.
//  Copyright © 2018年 Tongji. All rights reserved.
//

import SwiftyJSON

struct LoginInfo {
    var username:String
    var email:String
    var success:String
    var token:String
    
    init(json: JSON) {
        if(json["success"].string == nil || json["success"].string != "true"){
            self.username = ""
            self.email = ""
            self.success = "false"
            self.token = ""
            return
        }
        self.username = json["username"].string!
        self.email = json["email"].string!
        self.success = json["success"].string!
        self.token = json["token"].string!
    }
}
