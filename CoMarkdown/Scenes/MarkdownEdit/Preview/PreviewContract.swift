//
//  PreviewContract.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/18.
//  Copyright © 2018年 Tongji. All rights reserved.
//

protocol PreviewView : class {
    
}

protocol PreviewPresenter {
    var router: PreviewViewRouter { get }
    func viewDidLoad()
}

class PreviewPresenterImplementation : PreviewPresenter {
    fileprivate weak var view: PreviewView?
    private(set) var router: PreviewViewRouter
    //fileprivate var addBookUseCase: PreviewUseCase
    
    init(view: PreviewView,
         router: PreviewViewRouter/*,
         addBookUseCase: AddBookUseCase*/) {
        self.view = view
        self.router = router
    }
    
    func viewDidLoad() {
        
    }
}
