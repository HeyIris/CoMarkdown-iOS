//
//  OnlineFileListUserCase.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/22.
//  Copyright © 2018年 Tongji. All rights reserved.
//

import Alamofire
import SwiftyJSON

class OnlineFileListUseCase {
    let apiClient = ApiClient.instance()
    
    func OnlineFileList(username: String, token: String) {
        Alamofire.request(apiClient.endPoint + PATH.onlineFileList.rawValue, method: .post, parameters: ["username":username,"token":token], encoding: URLEncoding.default)
            .responseJSON{ response in
                guard response.result.error == nil else {
                    print(response.result.error!)
                    return
                }
                
                if let value = response.result.value{
                    let json = JSON(value)
                    if(json["success"].string! == "true"){
                        
                    }
                    print(json)
                }
        }
    }
}
