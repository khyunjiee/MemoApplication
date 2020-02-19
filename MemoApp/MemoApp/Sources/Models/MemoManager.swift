//
//  MemoManager.swift
//  MemoApp
//
//  Created by 김현지 on 2020/02/18.
//  Copyright © 2020 김현지. All rights reserved.
//

import UIKit
import SQLite3

class MemoManager: NSObject{
    // id, title, body, image[]
    let id: NSInteger = 0
    let title: NSString = ""
    let body: NSString = ""
    let image: NSArray = []
    
    private func createMemo(title: NSString, body: NSString, image: NSArray){
        var createStatement: OpaquePointer? = nil
        let createStatementString = "INSERT INTO Memo(title, body, image) VALUES(?, ?, ?);"
        
//        if sqlite3_prepare(db, createStatementString, -1, &createStatement, nil) == SQLITE_OK {
//
//        }
    }
    
    private func updateMemo(id: NSInteger, title: NSString, body: NSString, image: NSArray){
        
    }
    
    private func deleteMemo(id: NSInteger){
        
    }
}
