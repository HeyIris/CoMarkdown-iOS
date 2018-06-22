//
//  RegisterUseCase.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/20.
//  Copyright © 2018年 Tongji. All rights reserved.
//

import Alamofire
import SwiftyJSON

class RegisterUseCase {
    let apiClient = ApiClient.instance()
    
    func Register(username: String, password: String, email: String, presenter: RegisterPresenter) {
        Alamofire.request(apiClient.endPoint + PATH.register.rawValue, method: .post, parameters: ["username":username,"password":password, "email":email], encoding: URLEncoding.default)
            .responseJSON{ response in
                guard response.result.error == nil else {
                    print(response.result.error!)
                    presenter.showToast(of: "Network Error: " + response.result.error.debugDescription)
                    return
                }
                
                if let value = response.result.value{
                    let registerInfo = RegisterInfo(json: JSON(value))
                    if(registerInfo.success == "false"){
                        presenter.showToast(of: "Register Failed")
                        return
                    }
                    presenter.showToast(of: "Register Success")
                    presenter.loginButtonPressed()
                }
        }
    }
}
