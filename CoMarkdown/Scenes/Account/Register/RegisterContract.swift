//
//  RegisterContract.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/15.
//  Copyright © 2018年 Tongji. All rights reserved.
//

protocol RegisterView : class {
    func showToast(of message: String)
}

protocol RegisterPresenter {
    var router: RegisterViewRouter { get }
    func viewDidLoad()
    
    func loginButtonPressed()
    func registerButtonPressed(username: String, password: String, email: String)
    func showToast(of message: String)
}

class RegisterPresenterImplementation : RegisterPresenter {
    fileprivate weak var view: RegisterView?
    private(set) var router: RegisterViewRouter
    fileprivate var registerUseCase: RegisterUseCase
    
    init(view: RegisterView,
         router: RegisterViewRouter,
         registerUseCase: RegisterUseCase) {
        self.view = view
        self.router = router
        self.registerUseCase = registerUseCase
    }
    
    func viewDidLoad() {
        
    }
    
    func loginButtonPressed() {
        router.presentLoginView()
    }
    
    func registerButtonPressed(username: String, password: String, email: String) {
        registerUseCase.Register(username: username, password: password, email: email, presenter: self)
    }
    
    func showToast(of message: String) {
        view?.showToast(of: message)
    }
}
