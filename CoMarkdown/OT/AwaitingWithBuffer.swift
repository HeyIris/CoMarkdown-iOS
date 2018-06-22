//
//  AwaitingWithBuffer.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/19.
//  Copyright © 2018年 Tongji. All rights reserved.
//

class AwaitingWithBuffer: ClientState {
    private var outstanding: [String]
    private var buffer: [String]
    
    init(outstanding: [String],buffer: [String]){
        self.outstanding = outstanding
        self.buffer = buffer
    }
    
    func applyClient(client:OTClient, operation:[String]) -> ClientState{
        return AwaitingWithBuffer(outstanding: outstanding, buffer: client.mergeOperation(outstanding: buffer, operation: operation))
    }
    
    func applyServer(client: OTClient, operation: [String]) -> ClientState {
        let temp1 = client.transformOperation(outstanding: outstanding, operation: operation)
        let temp2 = client.transformOperation(outstanding: buffer, operation: temp1[1])
        client.applyOperation(operation: temp2[1])
        return AwaitingWithBuffer(outstanding: temp1[0], buffer: temp2[0])
    }
    
    func serverAck(client: OTClient) -> ClientState {
        client.sendOperation(operation: buffer)
        return AwaitingConfirm(outstanding: buffer)
    }
}
