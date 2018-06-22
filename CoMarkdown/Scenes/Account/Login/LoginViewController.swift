//
//  LoginViewController.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/15.
//  Copyright © 2018年 Tongji. All rights reserved.
//

import UIKit
import Toast_Swift

class LoginViewController: UIViewController, LoginView {
    var presenter: LoginPresenter!
    var configurator = LoginConfiguratorImplementation()

    @IBOutlet weak var accountField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(loginViewController: self)
        presenter.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        presenter.router.prepare(for: segue, sender: sender)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBAction
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        presenter.registerButtonPressed()
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        presenter.loginButtonPressed(username: accountField.text!, password: passwordField.text!)
    }
    
    // MARK: - LoginView
    func showToast(of message: String) {
        self.view.makeToast(message)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
