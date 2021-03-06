//
//  LoginConfigurator.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/15.
//  Copyright © 2018年 Tongji. All rights reserved.
//

import Foundation

protocol LoginConfigurator {
    func configure(loginViewController: LoginViewController)
}

class LoginConfiguratorImplementation: LoginConfigurator{
    func configure(loginViewController: LoginViewController) {
        /*
         let apiClient = ApiClientImplementation(urlSessionConfiguration: URLSessionConfiguration.default,
         completionHandlerQueue: OperationQueue.main)
         let apiBooksGateway = ApiBooksGatewayImplementation(apiClient: apiClient)
         let viewContext = CoreDataStackImplementation.sharedInstance.persistentContainer.viewContext
         let coreDataBooksGateway = CoreDataBooksGateway(viewContext: viewContext)
         
         let booksGateway = CacheBooksGateway(apiBooksGateway: apiBooksGateway,
         localPersistenceBooksGateway: coreDataBooksGateway)
         
         let addBookUseCase = AddBookUseCaseImplementation(booksGateway: booksGateway)
         let router = AddBookViewRouterImplementation(addBookViewController: addBookViewController)
         
         let presenter = AddBookPresenterImplementation(view: addBookViewController, addBookUseCase: addBookUseCase, router: router, delegate: addBookPresenterDelegate)
         
         addBookViewController.presenter = presenter
         */
        
        let loginUseCase = LoginUseCase()
        let router = LoginViewRouterImplementation(loginViewController: loginViewController)
        let presenter = LoginPresenterImplementation(view: loginViewController,router: router, loginUseCase: loginUseCase)
        loginViewController.presenter = presenter
    }
}
