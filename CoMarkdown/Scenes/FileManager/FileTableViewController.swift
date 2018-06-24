//
//  FileTableViewController.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/21.
//  Copyright © 2018年 Tongji. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FileTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as URL
    var fileList = [String]()
    var onlineFileList = [OnlineFileItem]()
    var partakeFileList = [PartakeFileItem]()
    var uploadFileUseCase = UploadFileUseCase()
    var downloadFileUseCase = DownloadFileUseCase()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fileList = searchFileList()
        getOnlineFileList(username: AccountInfo.instance().username, token: AccountInfo.instance().token)
        getPartakeFileList(username: AccountInfo.instance().username, token: AccountInfo.instance().token)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Local File"
        case 1:
            return "Online File"
        case 2:
            return "Partake File"
        default:
            return ""
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return fileList.count
        case 1:
            return onlineFileList.count
        case 2:
            return partakeFileList.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "FileTableViewCell", for: indexPath) as! FileTableViewCell
        switch section {
        case 0:
            cell.fileName.text = fileList[row]
            cell.fileOwner.text = "Local"
        case 1:
            cell.fileName.text = onlineFileList[row].name
            cell.fileOwner.text = "by " + AccountInfo.instance().username
        case 2:
            cell.fileName.text = partakeFileList[row].name
            cell.fileOwner.text = "by " + partakeFileList[row].master
        default:
            cell.fileName.text = "Nil"
            cell.fileOwner.text = "by Nil"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        switch section {
        case 0:
            EditContent.instance().fileName = fileList[row]
        case 1:
            //downloadMDFile(indexPath: indexPath)
            EditContent.instance().fileName = onlineFileList[row].name
            AccountInfo.instance().file.name = onlineFileList[row].name
            AccountInfo.instance().file.master = AccountInfo.instance().username
            AccountInfo.instance().file.id = onlineFileList[row].id
        case 2:
            //downloadMDFile(indexPath: indexPath)
            EditContent.instance().fileName = partakeFileList[row].name
            AccountInfo.instance().file.name = partakeFileList[row].name
            AccountInfo.instance().file.master = partakeFileList[row].master
            AccountInfo.instance().file.id = partakeFileList[row].id
        default:
            tableView.makeToast("Not Exist File")
        }
        let fileUrl = self.url.appendingPathComponent(EditContent.instance().fileName)
        let fileExists = FileManager.default.fileExists(atPath: fileUrl.path)
        if(fileExists && section == 0) {
            EditContent.instance().fileContent = try! String(contentsOf: fileUrl, encoding: String.Encoding.utf8)
            self.performSegue(withIdentifier: "ShowMarkdown", sender: nil)
            return
        } else if(!fileExists && section == 0) {
            return
        }
        var master: String = ""
        var filename: String = ""
        switch section{
        case 1:
            master = AccountInfo.instance().username
            filename = self.onlineFileList[row].name
        case 2:
            master = self.partakeFileList[row].master
            filename = self.partakeFileList[row].name
        default:
            self.tableView.makeToast("Can't Download Local File")
        }
        let apiClient = ApiClient.instance()
        //let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory, in: .userDomainMask)
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(filename)
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        Alamofire.download(apiClient.endPoint + PATH.downloadFile.rawValue, method: .post, parameters: ["username": AccountInfo.instance().username,"token": AccountInfo.instance().token,"master":master,"filename":filename], to: destination)
            .responseData { (response) in
                if response.result.value != nil {
                    self.performSegue(withIdentifier: "ShowMarkdown", sender: nil)
                }
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let section = indexPath.section
        let row = indexPath.row
        let delete = UIContextualAction(style: .destructive, title: "Delete"){
            (action,index,handler) in
            self.deleteMDFile(indexPath: indexPath)
        }
        delete.backgroundColor = UIColor.red
        
        let upload = UIContextualAction(style: .normal, title: "Upload"){
            (action,index,handler) in
            switch section{
            case 0:
                self.uploadMDFile(name: self.fileList[row])
            default:
                self.tableView.makeToast("Can't Upload Remote File")
            }
        }
        upload.backgroundColor = UIColor.orange
        
        let download = UIContextualAction(style: .normal, title: "Download"){
            (action,index,handler) in
            switch section{
            case 1:
                self.downloadFileUseCase.DownloadFile(username: AccountInfo.instance().username, token: AccountInfo.instance().token, master: AccountInfo.instance().username, filename: self.onlineFileList[row].name)
            case 2:
                self.downloadFileUseCase.DownloadFile(username: AccountInfo.instance().username, token: AccountInfo.instance().token, master: self.partakeFileList[row].master, filename: self.partakeFileList[row].name)
            default:
                self.tableView.makeToast("Can't Download Local File")
            }
        }
        download.backgroundColor = UIColor.orange
        
        var configuration: UISwipeActionsConfiguration
        switch section {
        case 0:
            configuration = UISwipeActionsConfiguration(actions: [delete,upload])
        case 1:
            configuration = UISwipeActionsConfiguration(actions: [delete,download])
        case 2:
            configuration = UISwipeActionsConfiguration(actions: [delete,download])
        default:
            configuration = UISwipeActionsConfiguration(actions: [])
        }
        
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
            let section = indexPath.section
            let row = indexPath.section
            switch section{
            case 0:
                self.fileList.remove(at: row)
            case 1:
                self.onlineFileList.remove(at: row)
            case 2:
                self.partakeFileList.remove(at: row)
            default:
                return
            }
            self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.middle)
            view.makeToast("Delete File" + name)
        } else {
            view.makeToast("Can't Delete File")
        }
    }
    
    func uploadMDFile(name: String){
        let manager = FileManager.default
        let file = self.url.appendingPathComponent(name)
        let exist = manager.fileExists(atPath: file.path)
        if exist {
            uploadFileUseCase.UploadFile(username: AccountInfo.instance().username, token: AccountInfo.instance().token, filename: name, file: file, viewController: self)
        }
    }
    
    func downloadMDFile(indexPath: IndexPath){
        let section = indexPath.section
        let row = indexPath.row
        switch section{
        case 1:
            self.downloadFileUseCase.DownloadFile(username: AccountInfo.instance().username, token: AccountInfo.instance().token, master: AccountInfo.instance().username, filename: self.onlineFileList[row].name)
        case 2:
            self.downloadFileUseCase.DownloadFile(username: AccountInfo.instance().username, token: AccountInfo.instance().token, master: self.partakeFileList[row].master, filename: self.partakeFileList[row].name)
        default:
            self.tableView.makeToast("Can't Download Local File")
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
    
    func getOnlineFileList(username: String, token: String) {
        let apiClient = ApiClient.instance()
        Alamofire.request(apiClient.endPoint + PATH.onlineFileList.rawValue, method: .post, parameters: ["username":username,"token":token], encoding: URLEncoding.default)
            .responseJSON{ response in
                guard response.result.error == nil else {
                    print(response.result.error!)
                    return
                }
                
                if let value = response.result.value{
                    let json = JSON(value)
                    if(json["success"].string! == "true"){
                        self.onlineFileList = OnlineFileInfo(data: json).list
                        for item in self.onlineFileList{
                            self.fileList = self.fileList.filter{
                                return $0 != item.name
                            }
                        }
                        self.tableView.reloadSections(IndexSet(0...1), with: UITableViewRowAnimation.left)
                        print(self.onlineFileList)
                    }
                }
        }
    }
    
    func getPartakeFileList(username: String, token: String){
        let apiClient = ApiClient.instance()
        Alamofire.request(apiClient.endPoint + PATH.partakeFileList.rawValue, method: .post, parameters: ["username":username,"token":token], encoding: URLEncoding.default)
            .responseJSON{ response in
                guard response.result.error == nil else {
                    print(response.result.error!)
                    return
                }
                
                if let value = response.result.value{
                    let json = JSON(value)
                    self.partakeFileList = PartakeFileInfo(data: json).partake_files
                    for item in self.partakeFileList{
                        self.fileList = self.fileList.filter{
                            return $0 != item.name
                        }
                    }
                    self.tableView.reloadData()
//                    self.tableView.reloadSections(IndexSet(0...0), with: UITableViewRowAnimation.left)
//                    self.tableView.reloadSections(IndexSet(2...2), with: UITableViewRowAnimation.left)
                    print(self.partakeFileList)
                }
        }
    }
}
