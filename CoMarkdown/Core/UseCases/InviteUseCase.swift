//
//  InviteUseCase.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/23.
//  Copyright © 2018年 Tongji. All rights reserved.
//

import Alamofire
import SwiftyJSON

class InviteUseCase {
    let apiClient = ApiClient.instance()
    
    func Invite(username: String, token: String, filename: String, invite: String) {
        Alamofire.request(apiClient.endPoint + PATH.invite.rawValue, method: .post, parameters: ["username":username,"token":token,"filename":filename,"invite":invite], encoding: URLEncoding.default)
            .responseJSON{ response in
                guard response.result.error == nil else {
                    print(response.result.error!)
                    return
                }
                
                if let value = response.result.value{
                    let json = JSON(value)
                    if(json["success"].string! == "true"){
                        return
                    }
                }
        }
    }
}
