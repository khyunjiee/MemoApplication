//
//  MemoDB.swift
//  MemoApp
//
//  Created by 김현지 on 2020/02/19.
//  Copyright © 2020 김현지. All rights reserved.
//

import UIKit
import SQLite3

class MemoDB: NSObject {
    var db: OpaquePointer?
    
    func openDB() -> Bool {
        guard let memoDbPath = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("db.sqlite") else {
            return false
        }
        
        if sqlite3_open(memoDbPath.path, &db) == SQLITE_OK {
            print("Success open database")
            return true
        } else {
            print("Fail open database")
            return false
        }
    }
    
    func createMemoTable() {
        let createTableString = """
        CREATE TABLE Memo(
        Id INT PRIMARY KEY NOT NULL,
        Title CHAR(255),
        Body CHAR(500),
        ImageList CHAR(1000));
        """
        
        var createTableStatement: OpaquePointer?
        
        if sqlite3_prepare(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Memo DB is created")
            } else {
                print("Memo DB is not created")
            }
        } else {
            print("CreateTableStatement is not prepared")
        }
        
        sqlite3_finalize(createTableStatement)
    }
    
    func insertMemo(id: Int, title: String?, body: String?, imageList: String?) {
        let insertMemoString = "INSERT INTO Memo (Id, Title, Body, ImageList) VALUES (?, ?, ?, ?);"
        
        var insertMemoStatement: OpaquePointer?
        
        let Id: Int32 = Int32(id)
        let Title: NSString = title as NSString? ?? "제목이 없습니다."
        let Body: NSString = body as NSString? ?? "내용이 없습니다."
        let ImageList: NSString = imageList as NSString? ?? ""
        
        if sqlite3_prepare(db, insertMemoString, -1, &insertMemoStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertMemoStatement, 1, Id)
            sqlite3_bind_text(insertMemoStatement, 2, Title.utf8String, -1, nil)
            sqlite3_bind_text(insertMemoStatement, 3, Body.utf8String, -1, nil)
            sqlite3_bind_text(insertMemoStatement, 4, ImageList.utf8String, -1, nil)
            
            if sqlite3_step(insertMemoStatement) == SQLITE_DONE {
                print("Success insert row")
            } else {
                print("Fail insert row")
            }
        } else {
            print("insertMemoStatement is not prepared")
        }
        
        sqlite3_finalize(insertMemoStatement)
    }
    
}
