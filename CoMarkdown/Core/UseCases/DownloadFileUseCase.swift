//
//  DownloadFileUseCase.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/22.
//  Copyright © 2018年 Tongji. All rights reserved.
//

import Alamofire
import SwiftyJSON

class DownloadFileUseCase {
    let apiClient = ApiClient.instance()
    
    func DownloadFile(username: String, token: String, master: String, filename: String) {
        let destination = DownloadRequest.suggestedDownloadDestination(for: .documentDirectory, in: .userDomainMask)
        Alamofire.download(apiClient.endPoint + PATH.downloadFile.rawValue, method: .post, parameters: ["username":username,"token": token,"master":master,"filename":filename], to: destination)
    }
}
