//
//  EditContent.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/21.
//  Copyright © 2018年 Tongji. All rights reserved.
//

class EditContent {
    var fileName: String
    var fileContent: String
    
    private static let editContent: EditContent = {
        let content = EditContent(fileName: "", fileContent: "")
        return content
    }()
    
    private init(fileName: String, fileContent: String){
        self.fileName = fileName
        self.fileContent = fileContent
    }
    
    class func instance() -> EditContent{
        return editContent
    }
}
