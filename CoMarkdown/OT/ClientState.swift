//
//  ClientState.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/19.
//  Copyright © 2018年 Tongji. All rights reserved.
//

protocol ClientState {
    func applyClient(client:OTClient, operation:[String]) -> ClientState
    
    func applyServer(client:OTClient, operation:[String]) -> ClientState
    
    func serverAck(client:OTClient) -> ClientState
}
