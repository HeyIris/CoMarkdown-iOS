//
//  EditViewController.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/18.
//  Copyright © 2018年 Tongji. All rights reserved.
//

import UIKit
import Google_Diff_Match_Patch

class EditViewController: UIViewController, EditView, UITextViewDelegate {
    var presenter: EditPresenter!
    var configurator = EditConfiguratorImplementation()
    var otClient: OTClient!
    var timer: Timer!

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(editViewController: self)
        addMenuItem()
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerAction(timer:)), userInfo: nil, repeats: true)
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
        otClient = OTClient(revision: 0, fileName: EditContent.instance().fileName, fileContent: EditContent.instance().fileContent, viewController: self)
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
        timer.invalidate()
        otClient.exitServer()
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
            if let invite = alert.textFields?.first?.text{
                self.presenter.invite(invite)
            }
        }
        alert.addAction(cancel)
        alert.addAction(confirm)
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func timerAction(timer: Timer){
        let diff = DiffMatchPatch()
        let diffList = diff.diff_main(ofOldString: otClient.file, andNewString: textView.text)!
        if(diffList.count == 1 && (diffList[0] as! Diff).operation == DIFF_EQUAL){
            return
        }
        var opList:[String] = [String]()
        for item in diffList{
            switch (item as! Diff).operation{
            case DIFF_EQUAL:
                opList.append("r" + String((item as! Diff).text!.count))
            case DIFF_DELETE:
                opList.append("d" + String((item as! Diff).text!.count))
            case DIFF_INSERT:
                opList.append("i" + (item as! Diff).text!)
            default:
                print("DEFAULT:")
            }
        }
        if(opList.count == 0){
            return
        } else if(opList.count == 1 && opList[0].first == "r"){
            return
        }
        otClient.applyOperation(operation: opList)
        otClient.applyClient(operation: opList)
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if(action == #selector(italics) ||
            action == #selector(bold) ||
            action == #selector(blockquotes) ||
            action == #selector(code)){
            return true
        }
        return false
    }
    
    func addMenuItem(){
        let italicsMenuItem = UIMenuItem(title: "Italics", action: #selector(italics))
        let boldMenuItem = UIMenuItem(title: "Bold", action: #selector(bold))
        let blockquotesMenuItem = UIMenuItem(title: "blockquotes", action: #selector(blockquotes))
        let codeMenuItem = UIMenuItem(title: "Code", action: #selector(code))
        UIMenuController.shared.menuItems = [italicsMenuItem,boldMenuItem,blockquotesMenuItem,codeMenuItem]
    }
    
    @objc func italics() {
        let range = textView.selectedRange
        let str = textView.text
        let startIndex = str!.index((str?.startIndex)!, offsetBy: range.location)
        let endIndex = str!.index((str?.startIndex)!, offsetBy: range.location + range.length - 1)
        textView.text = str?.replacingCharacters(in: startIndex...endIndex, with: "*\(str![startIndex...endIndex])*")
    }
    
    @objc func bold() {
        let range = textView.selectedRange
        let str = textView.text
        let startIndex = str!.index((str?.startIndex)!, offsetBy: range.location)
        let endIndex = str!.index((str?.startIndex)!, offsetBy: range.location + range.length - 1)
        textView.text = str?.replacingCharacters(in: startIndex...endIndex, with: "**\(str![startIndex...endIndex])**")
    }
    
    @objc func blockquotes() {
        let range = textView.selectedRange
        let str = textView.text
        let startIndex = str!.index((str?.startIndex)!, offsetBy: range.location)
        let endIndex = str!.index((str?.startIndex)!, offsetBy: range.location + range.length - 1)
        textView.text = str?.replacingCharacters(in: startIndex...endIndex, with: "> \(str![startIndex...endIndex])")
    }
    
    @objc func code() {
        let range = textView.selectedRange
        let str = textView.text
        let startIndex = str!.index((str?.startIndex)!, offsetBy: range.location)
        let endIndex = str!.index((str?.startIndex)!, offsetBy: range.location + range.length - 1)
        textView.text = str?.replacingCharacters(in: startIndex...endIndex, with: "```\n\(str![startIndex...endIndex])\n```")
    }
}
