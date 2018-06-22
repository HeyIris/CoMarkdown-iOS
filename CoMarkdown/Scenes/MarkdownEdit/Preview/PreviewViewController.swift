//
//  PreviewViewController.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/18.
//  Copyright © 2018年 Tongji. All rights reserved.
//

import UIKit
import MarkdownView

class PreviewViewController: UIViewController, PreviewView {
    var presenter: PreviewPresenter!
    var configurator = PreviewConfiguratorImplementation()

    @IBOutlet weak var mdView: MarkdownView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(previewViewController: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.mdView.load(markdown: EditContent.instance().fileContent)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
