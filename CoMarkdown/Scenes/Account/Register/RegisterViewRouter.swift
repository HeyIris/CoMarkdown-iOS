//
//  RegisterViewRouter.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/15.
//  Copyright © 2018年 Tongji. All rights reserved.
//

import UIKit

protocol RegisterViewRouter: ViewRouter {
    func presentLoginView()
    func presentEditView()
}

class RegisterViewRouterImplementation : RegisterViewRouter{
    fileprivate weak var registerViewController: RegisterViewController?
    
    init(registerViewController: RegisterViewController) {
        self.registerViewController = registerViewController
    }
    
    func presentLoginView() {
        registerViewController?.performSegue(withIdentifier: "ShowLogin", sender: nil)
    }
    
    func presentEditView() {
        
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let loginViewController = segue.destination as? LoginViewController{
            loginViewController.configurator = LoginConfiguratorImplementation()
        }
    }
}
