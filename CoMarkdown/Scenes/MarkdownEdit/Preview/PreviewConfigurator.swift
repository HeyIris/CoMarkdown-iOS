//
//  PreviewConfigurator.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/18.
//  Copyright © 2018年 Tongji. All rights reserved.
//

protocol PreviewConfigurator {
    func configure(previewViewController: PreviewViewController)
}

class PreviewConfiguratorImplementation: PreviewConfigurator{
    func configure(previewViewController: PreviewViewController) {
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
        
        let router = PreviewViewRouterImplementation(previewViewController: previewViewController)
        let presenter = PreviewPresenterImplementation(view: previewViewController,router: router)
        previewViewController.presenter = presenter
    }
}
