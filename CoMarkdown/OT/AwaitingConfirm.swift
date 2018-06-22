//
//  AwaitingConfirm.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/19.
//  Copyright © 2018年 Tongji. All rights reserved.
//

class AwaitingConfirm: ClientState {
    private var outstanding: [String]
    
    init(outstanding: [String]){
        self.outstanding = outstanding
    }
    
    func applyClient(client:OTClient, operation:[String]) -> ClientState{
        return AwaitingWithBuffer(outstanding: outstanding, buffer: operation)
    }
    
    func applyServer(client: OTClient, operation: [String]) -> ClientState {
        let temp = client.transformOperation(outstanding: outstanding, operation: operation)
        client.applyClient(operation: temp[1])
        return AwaitingConfirm(outstanding: temp[0])
    }
    
    func serverAck(client: OTClient) -> ClientState {
        return Synchronized.instance()
    }
}
