//
//  AccountInfo.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/19.
//  Copyright © 2018年 Tongji. All rights reserved.
//

import Foundation

class AccountInfo {
    var username: String
    var email: String
    var token: String
    var file: PartakeFileItem
    var filepath: String
    
    private static let accountInfo: AccountInfo = {
        let info = AccountInfo(username: "", email: "", token: "", file: PartakeFileItem(), filepath: "")
        return info
    }()
    
    private init(username: String, email: String, token: String, file: PartakeFileItem, filepath: String){
        self.username = username
        self.email = email
        self.token = token
        self.file = file
        self.filepath = filepath
    }
    
    class func instance() -> AccountInfo{
        return accountInfo
    }
}
