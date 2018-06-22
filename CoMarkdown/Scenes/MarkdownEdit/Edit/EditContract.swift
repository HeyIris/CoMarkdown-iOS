//
//  EditContract.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/18.
//  Copyright © 2018年 Tongji. All rights reserved.
//

protocol EditView : class {
    
}

protocol EditPresenter {
    var router: EditViewRouter { get }
    func viewDidLoad()
}

class EditPresenterImplementation : EditPresenter {
    fileprivate weak var view: EditView?
    private(set) var router: EditViewRouter
    //fileprivate var addBookUseCase: EditUseCase
    
    init(view: EditView,
         router: EditViewRouter/*,
         addBookUseCase: AddBookUseCase*/) {
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {
        
    }
}
