//
//  EditViewController.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/18.
//  Copyright © 2018年 Tongji. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, EditView, UITextViewDelegate {
    var presenter: EditPresenter!
    var configurator = EditConfiguratorImplementation()

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(editViewController: self)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidChange(_ textView: UITextView) {
        EditContent.instance().fileContent = textView.text
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(EditContent.instance().fileName == ""){
            return
        }
        textView.text = EditContent.instance().fileContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if(EditContent.instance().fileName == ""){
            return
        }
        let manager = FileManager.default
        var url = manager.urls(for: .documentDirectory, in: .userDomainMask)[0] as URL
        url = url.appendingPathComponent(EditContent.instance().fileName)
        if(manager.fileExists(atPath: url.path)){
            do{
                try EditContent.instance().fileContent.write(to: url, atomically: true, encoding: String.Encoding.utf8)
            }
            catch{
            }
        }
    }

    // MARK: - IBAction
    @IBAction func inviteButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title:"Invite",message:"Please Input His/Her Username",preferredStyle:.alert)
        alert.addTextField(configurationHandler: {(textField)in
            textField.placeholder="Username"
            textField.keyboardType = .default
        })
        let cancel=UIAlertAction(title:"Cancel",style:.cancel)
        let confirm=UIAlertAction(title:"Confirm",style:.default){(action)in
            print("rua")
        }
        alert.addAction(cancel)
        alert.addAction(confirm)
        present(alert, animated: true, completion: nil)
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
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
