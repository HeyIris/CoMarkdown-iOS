//
//  EditConfigurator.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/18.
//  Copyright © 2018年 Tongji. All rights reserved.
//

protocol EditConfigurator {
    func configure(editViewController: EditViewController)
}

class EditConfiguratorImplementation: EditConfigurator{
    func configure(editViewController: EditViewController) {
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
        
        let inviteUseCase = InviteUseCase()
        let router = EditViewRouterImplementation(editViewController: editViewController)
        let presenter = EditPresenterImplementation(view: editViewController,router: router, inviteUseCase: inviteUseCase)
        editViewController.presenter = presenter
    }
}
