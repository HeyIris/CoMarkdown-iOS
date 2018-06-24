//
//  ApiClient.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/20.
//  Copyright © 2018年 Tongji. All rights reserved.
//


enum PATH: String {
    case login = "login/"
    case register = "register/"
    case uploadFile = "upload_file/"
    case downloadFile = "download_file/"
    case onlineFileList = "master_files/"
    case partakeFileList = "partake_files/"
    case createServer = "create_server/"
    case exitServer = "exit_coorperative_edit/"
    case doOT = "do_OT/"
    case invite = "invite/"
    
}

class ApiClient {
    private static let apiClient: ApiClient = {
        let client = ApiClient()
        return client
    }()
    
    private init(){
    }
    
    class func instance() -> ApiClient {
        return apiClient
    }
    
    let endPoint: String = "http://119.23.10.99:9874/"
}
