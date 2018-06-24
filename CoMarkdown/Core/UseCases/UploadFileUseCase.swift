//
//  UploadFileUseCase.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/22.
//  Copyright © 2018年 Tongji. All rights reserved.
//

import Alamofire
import SwiftyJSON

class UploadFileUseCase {
    let apiClient = ApiClient.instance()
    
    func UploadFile(username: String, token: String, filename: String, file: URL, viewController: FileTableViewController) {
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(username.data(using: String.Encoding.utf8)!, withName: "username")
            multipartFormData.append(token.data(using: String.Encoding.utf8)!, withName: "token")
            multipartFormData.append(filename.data(using: String.Encoding.utf8)!, withName: "filename")
            multipartFormData.append(file, withName: "file", fileName: filename, mimeType: "text/x-markdown")
        }, to: apiClient.endPoint + PATH.uploadFile.rawValue, method: .post){
            result in
            switch result{
            case .success(let upload, _, _):
                upload.responseJSON{ response in
                    guard response.result.error == nil else {
                        print(response.result.error!)
                        return
                    }
                    
                    if let value = response.result.value{
                        let json = JSON(value)
                        if(json["success"].string == "true"){
                            viewController.view.makeToast("Upload Success")
                        } else {
                            viewController.view.makeToast("Upload Failed")
                        }
                    }
                }
            case .failure(let encodingError):
                print(encodingError)
            }
        }
    }
}
