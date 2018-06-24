//
//  LoginUseCase.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/20.
//  Copyright © 2018年 Tongji. All rights reserved.
//

import Alamofire
import SwiftyJSON

class LoginUseCase {
    let apiClient = ApiClient.instance()
    
    func Login(username: String, password: String, presenter: LoginPresenter) {
        Alamofire.request(apiClient.endPoint + PATH.login.rawValue, method: .post, parameters: ["username":username,"password":password], encoding: URLEncoding.default)
            .responseJSON{ response in
                guard response.result.error == nil else {
                    print(response.result.error!)
                    presenter.showToast(of: "Network Error: " + response.result.error.debugDescription)
                    return
                }
                
                if let value = response.result.value{
                    let loginInfo = LoginInfo(json: JSON(value))
                    if(loginInfo.success == "false"){
                        presenter.showToast(of: "Login Failed: wrong username or password")
                        return
                    }
                    AccountInfo.instance().username = loginInfo.username
                    AccountInfo.instance().email = loginInfo.email
                    AccountInfo.instance().token = loginInfo.token
                    presenter.showToast(of: "Login Success As " + AccountInfo.instance().username)
                    presenter.loginSuccess()
                }
        }
    }
}
