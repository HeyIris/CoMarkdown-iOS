//
//  RegisterViewController.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/15.
//  Copyright © 2018年 Tongji. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, RegisterView {
    var presenter: RegisterPresenter!
    var configurator: RegisterConfigurator!
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(registerViewController: self)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBAction
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        presenter.loginButtonPressed()
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        presenter.registerButtonPressed(username: usernameField.text!, password: passwordField.text!, email: emailField.text!)
    }
    
    // MARK: - RegisterView
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
