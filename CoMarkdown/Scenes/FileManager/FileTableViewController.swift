//
//  FileTableViewController.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/21.
//  Copyright © 2018年 Tongji. All rights reserved.
//

import UIKit

class FileTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as URL
    var fileList = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fileList = searchFileList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fileList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FileTableViewCell", for: indexPath) as! FileTableViewCell
        cell.fileName.text = fileList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        EditContent.instance().fileName = (tableView.cellForRow(at: indexPath) as! FileTableViewCell).fileName.text!
        let fileUrl = self.url.appendingPathComponent(EditContent.instance().fileName)
        if FileManager.default.fileExists(atPath: fileUrl.path) {
            EditContent.instance().fileContent = try! String(contentsOf: fileUrl, encoding: String.Encoding.utf8)
        }
        self.performSegue(withIdentifier: "ShowMarkdown", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "Delete"){
            (action,index,handler) in
            self.deleteMDFile(indexPath: indexPath)
        }
        delete.backgroundColor = UIColor.red
        let configuration = UISwipeActionsConfiguration(actions: [delete])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
    func searchFileList() -> [String] {
        var list = [String]()
        if let contentsOfPath = try? FileManager.default.contentsOfDirectory(atPath: url.path){
            for item in contentsOfPath{
                if(item.contains(".md")){
                    list.append(item)
                }
            }
        }
        return list
    }
    
    // MARK: - IBAction
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title:"Add New File",message:"Please Input File Name",preferredStyle:.alert)
        alert.addTextField(configurationHandler: {(textField)in
            textField.placeholder="FileName"
            textField.keyboardType = .default
        })
        let cancel=UIAlertAction(title:"Cancel",style:.cancel)
        let confirm=UIAlertAction(title:"Confirm",style:.default){(action)in
            if let name = alert.textFields?.first?.text{
                let fileName = self.addNewFile(name: name)
                if(fileName != ""){
                    self.addNewRow(name: fileName)
                }
            }
        }
        alert.addAction(cancel)
        alert.addAction(confirm)
        present(alert, animated: true, completion: nil)
    }
    
    func deleteMDFile(indexPath : IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FileTableViewCell
        let name = cell.fileName.text!
        if(self.deleteFile(name: name)){
            self.fileList.remove(at: indexPath.item)
            self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.left)
            view.makeToast("Delete File" + name)
        } else {
            view.makeToast("Can't Delete File")
        }
    }
    
    func addNewFile(name: String) -> String{
        let manager = FileManager.default
        var fileName: String
        if(name.contains(".md")){
            fileName = name
        } else {
            fileName = name + ".md"
        }
        let file = self.url.appendingPathComponent(fileName)
        let exist = manager.fileExists(atPath: file.path)
        if !exist {
            manager.createFile(atPath: file.path,contents:nil,attributes:nil)
            return fileName
        }
        return ""
    }
    
    func addNewRow(name: String) {
        let row = self.fileList.count
        let indexPath = IndexPath(row: row, section: 0)
        self.fileList.append(name)
        self.tableView?.insertRows(at: [indexPath], with: UITableViewRowAnimation.left)
    }
    
    func deleteFile(name: String) -> Bool {
        let manager = FileManager.default
        let file = self.url.appendingPathComponent(name)
        let exist = manager.fileExists(atPath: file.path)
        if exist && manager.isDeletableFile(atPath: file.path) {
            do{
                try manager.removeItem(at: file)
            }
            catch{
                return false
            }
            return true
        }
        return false
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
