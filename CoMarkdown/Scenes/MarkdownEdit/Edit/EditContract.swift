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
    func invite(_ invite: String)
}

class EditPresenterImplementation : EditPresenter {
    fileprivate weak var view: EditView?
    private(set) var router: EditViewRouter
    fileprivate var inviteUseCase: InviteUseCase
    
    init(view: EditView,
         router: EditViewRouter,
         inviteUseCase: InviteUseCase) {
        self.view = view
        self.router = router
        self.inviteUseCase = inviteUseCase
    }
    
    func viewDidLoad() {
        
    }
    
    func invite(_ invite: String) {
        inviteUseCase.Invite(username: AccountInfo.instance().username, token: AccountInfo.instance().token, filename: AccountInfo.instance().file.name, invite: invite)
    }
}
