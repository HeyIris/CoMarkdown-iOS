//
//  OTClient.swift
//  CoMarkdown
//
//  Created by 陈湃轩 on 2018/6/19.
//  Copyright © 2018年 Tongji. All rights reserved.
//

class OTClient{
    private var revision: Int
    private var state: ClientState
    var name: String
    var file: String
    private var fileID: Int = -1
    
    init(revision:Int, fileName:String, fileContent:String) {
        self.revision = revision
        state = Synchronized.instance()
        self.name = fileName
        self.file = fileContent
    }
    
    func applyClient(operation: [String]) {
        state = state.applyClient(client: self, operation: operation)
    }
    
    func applyServer(operation: [String]) {
        revision += 1
        state = state.applyServer(client: self, operation: operation)
    }
    
    func serverAck() {
        revision += 1
        state = state.serverAck(client: self)
    }
    
    func searchFile(){
    }
    
    func createServer(){
    }
    
    func exitServer(){
    }
    
    func sendOperation(operation: [String]) {
    }
    
    func applyOperation(operation: [String]) {
        var result = ""
        var pos = 0
        var length = 0
        for item in operation {
            switch(item[item.startIndex]){
            case "r":
                length = Int(item[item.index(item.startIndex, offsetBy: 1)...item.endIndex])!
                result += file[file.index(file.startIndex, offsetBy: pos)...file.index(file.startIndex, offsetBy: pos + length)]
                pos += length
            case "d":
                length = Int(item[item.index(item.startIndex, offsetBy: 1)...item.endIndex])!
                pos += length
            case "i":
                result += item[item.index(item.startIndex, offsetBy: 1)...item.endIndex]
            default:
                length += 0
            }
        }
        //EventBus.getDefault().post(ApplyChangeEvent(file, result))
        file = result
    }
    
    func mergeOperation(outstanding: [String], operation: [String]) -> [String] {
        var pos1 = -1
        var pos2 = -1
        var a = ""
        var b = ""
        var result = [String]()
        var minLength: Int
        var lengthA: Int
        var lengthB: Int
        while (true) {
            if (a == "") {
                pos1 += 1
                if (pos1 < outstanding.count) {
                    a = outstanding[pos1]
                }
            }
            if (b == "") {
                pos2 += 1
                if (pos2 < operation.count) {
                    b = operation[pos2]
                }
            }
            if ((a == "") && (b == "")) {
                break
            }
            if (isDelete(a)) {
                result.append(a)
                a = ""
                continue
            }
            if (isInsert(b)) {
                result.append(b)
                b = ""
                continue
            }
            if ((a == "") || (b == "")) {
                result = [String]()
                break
            }
            lengthA = lengthOfOperation(op: a)
            lengthB = lengthOfOperation(op: b)
            minLength = min(lengthA, lengthB)
            if (isRetain(a) && isRetain(b)) {
                result.append("r" + String(minLength))
            } else if (isInsert(a) && isRetain(b)) {
                result.append("i" + a[a.index(a.startIndex, offsetBy: 1)...a.endIndex])
            } else if (isRetain(a) && isDelete(b)) {
                result.append("d" + String(minLength))
            }
            lengthA = lengthOfOperation(op: a)
            lengthB = lengthOfOperation(op: b)
            if (lengthA == lengthB) {
                a = ""
                b = ""
            } else if (lengthA > lengthB) {
                a = shortenOperation(op: a, by: lengthB)
                b = ""
            } else {
                a = ""
                b = shortenOperation(op: b, by: lengthA)
            }
        }
        return result
    }
    
    func transformOperation(outstanding: [String], operation: [String]) -> [[String]] {
        var result = [[String]]()
        result.append([String]())
        result.append([String]())
        var pos1 = -1
        var pos2 = -1
        var a = ""
        var b = ""
        var minLength: Int
        var lengthA: Int
        var lengthB: Int
        while (true) {
            if (a == "") {
                pos1 += 1
                if (pos1 < outstanding.count) {
                    a = outstanding[pos1]
                }
            }
            if (b == "") {
                pos2 += 1
                if (pos2 < operation.count) {
                    b = operation[pos2]
                }
            }
            if ((a == "") && (b == "")) {
                break
            }
            if (isInsert(a)) {
                result[0].append(a)
                result[1].append("r" + String(lengthOfOperation(op: a)))
                a = ""
                continue
            }
            if (isInsert(b)) {
                result[0].append("r" + String(lengthOfOperation(op: b)))
                result[1].append(b)
                b = ""
                continue
            }
            if ((a == "") || (b == "")) {
                result = [[String]]()
                break
            }
            lengthA = lengthOfOperation(op: a)
            lengthB = lengthOfOperation(op: b)
            minLength = min(lengthA, lengthB)
            if (isRetain(a) && isRetain(b)) {
                result[0].append("r" + String(minLength))
                result[1].append("r" + String(minLength))
            } else if (isDelete(a) && isRetain(b)) {
                result[0].append("d" + String(minLength))
            } else if (isRetain(a) && isDelete(b)) {
                result[1].append("d" + String(minLength))
            }
            lengthA = lengthOfOperation(op: a)
            lengthB = lengthOfOperation(op: b)
            if (lengthA == lengthB) {
                a = ""
                b = ""
            } else if (lengthA > lengthB) {
                a = shortenOperation(op: a, by: lengthB)
                b = ""
            } else {
                a = ""
                b = shortenOperation(op: b, by: lengthA)
            }
        }
        var results = [[String]]()
        results.append(result[0])
        results.append(result[1])
        return results
    }
    
    private func lengthOfOperation(op: String) -> Int {
        var length = 0
        switch op[op.startIndex] {
        case "r":
            length = Int(op[op.index(op.startIndex, offsetBy: 1)...op.endIndex])!
        case "d":
            length = Int(op[op.index(op.startIndex, offsetBy: 1)...op.endIndex])!
        case "i":
            length = op.count - 1
        default:
            length = 0
        }
        return length
    }
    
    private func isRetain(_ op: String) -> Bool {
        return (op.count > 1 && op[op.startIndex] == "r")
    }
    
    private func isDelete(_ op: String) -> Bool {
        return (op.count > 1 && op[op.startIndex] == "d")
    }
    
    private func isInsert(_ op: String) -> Bool {
        return (op.count > 1 && op[op.startIndex] == "i")
    }
    
    private func shortenOperation(op: String, by: Int) -> String {
        if (isInsert(op)) {
            return String(op[op.startIndex...op.index(op.startIndex, offsetBy: by)])
        } else if (isDelete(op)) {
            return "d" + String(lengthOfOperation(op: op) - by)
        } else if (isRetain(op)) {
            return "r" + String(lengthOfOperation(op: op) - by)
        }
        return "r0"
    }
}
