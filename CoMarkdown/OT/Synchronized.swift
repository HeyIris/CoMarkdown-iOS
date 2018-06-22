//
//  Synchronized.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/19.
//  Copyright © 2018年 Tongji. All rights reserved.
//

class Synchronized: ClientState {
    private static let synchronized: Synchronized = {
        let temp = Synchronized()
        return temp
    }()
    
    private init(){
    }
    
    class func instance() -> Synchronized{
        return synchronized
    }
    
    func applyClient(client:OTClient, operation:[String]) -> ClientState{
        client.sendOperation(operation: operation)
        return AwaitingConfirm(outstanding: operation)
    }
    
    func applyServer(client: OTClient, operation: [String]) -> ClientState {
        client.applyOperation(operation: operation)
        return Synchronized.instance()
    }
    
    func serverAck(client: OTClient) -> ClientState {
        return Synchronized.instance()
    }
}
