//
//  LoginContract.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/15.
//  Copyright © 2018年 Tongji. All rights reserved.
//

protocol LoginView : class {
    func showToast(of message: String)
}

protocol LoginPresenter {
    var router: LoginViewRouter { get }
    func viewDidLoad()
    
    func registerButtonPressed()
    func loginButtonPressed(username: String, password: String)
    func loginSuccess()
    func showToast(of message: String)
}

class LoginPresenterImplementation : LoginPresenter {
    fileprivate weak var view: LoginView?
    private(set) var router: LoginViewRouter
    fileprivate var loginUseCase: LoginUseCase
    
    init(view: LoginView,
         router: LoginViewRouter,
        loginUseCase: LoginUseCase) {
        self.view = view
        self.router = router
        self.loginUseCase = loginUseCase
    }
    
    func viewDidLoad() {
        
    }
    
    func registerButtonPressed() {
        router.presentRegisterView()
    }
    
    func loginButtonPressed(username: String, password: String) {
        loginUseCase.Login(username: username, password: password, presenter: self)
    }
    
    func loginSuccess() {
        router.presentEditView()
    }
    
    func showToast(of message: String) {
        view?.showToast(of: message)
    }
}
