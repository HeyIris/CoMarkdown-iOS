//
//  LoginViewRouter.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/15.
//  Copyright © 2018年 Tongji. All rights reserved.
//

import UIKit

protocol LoginViewRouter: ViewRouter {
    func presentRegisterView()
    func presentEditView()
}

class LoginViewRouterImplementation : LoginViewRouter{
    fileprivate weak var loginViewController: LoginViewController?
    
    init(loginViewController: LoginViewController) {
        self.loginViewController = loginViewController
    }
    
    func presentRegisterView() {
        loginViewController?.performSegue(withIdentifier: "ShowRegister", sender: nil)
    }
    
    func presentEditView() {
        loginViewController?.performSegue(withIdentifier: "ShowFileManager", sender: nil)
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let registerViewController = segue.destination as? RegisterViewController{
            registerViewController.configurator = RegisterConfiguratorImplementation()
        }
    }
}
