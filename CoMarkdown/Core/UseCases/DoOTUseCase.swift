//
//  DoOTUseCase.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/23.
//  Copyright © 2018年 Tongji. All rights reserved.
//

import Alamofire
import SwiftyJSON

class DoOTUseCase {
    let apiClient = ApiClient.instance()
    
    func DoOT(master: String, id: Int, username: String, token : String, operation: [String], revision: Int) {
        Alamofire.request(apiClient.endPoint + PATH.doOT.rawValue + "\(master)@\(id)/", method: .post, parameters: ["username":username,"token":token,"operation":operation,"revision":revision], encoding: URLEncoding.default)
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
