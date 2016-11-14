//
//  MemoRealmTests.swift
//  Koguryo
//
//  Created by KimJungSu on 11/11/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import XCTest
import RealmSwift

@testable import Koguryo

class MemoRealmTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        
        super.tearDown()
        
        self.deleteAllMemos()
    }
    
    //  Memo add
    
    func testMemoAdd() {
        
        let manager = MemoManager.init()
        
        let memo = RealmMemo.init(value: ["contents" : "contents", "placeHolder": "placeHolder"])

        manager.addMemo(memo)
        
        XCTAssertEqual(1, manager.getMemoCount(withType: .normal))
    }
    
    func testMemosAdd() {
        
        let manager = MemoManager.init()
        
        let memo_1 = RealmMemo.init(value: ["contents" : "contents_1", "placeHolder": "placeHolder_1"])
        let memo_2 = RealmMemo.init(value: ["contents" : "contents_2", "placeHolder": "placeHolder_2"])
        let memo_3 = RealmMemo.init(value: ["contents" : "contents_3", "placeHolder": "placeHolder_3"])
        
        manager.addMemo(memo_1)
        manager.addMemo(memo_2)
        manager.addMemo(memo_3)
        
        XCTAssertEqual(3, manager.getMemoCount(withType: .normal))
    }

    
    //  Favorite memo count
    
    func testCountFavoriteMemos() {

        let manager = MemoManager.init()
        
        let memo_1 = RealmMemo.init(value: ["contents" : "contents_1", "placeHolder": "placeHolder_1"])
        let memo_2 = RealmMemo.init(value: ["contents" : "contents_2", "placeHolder": "placeHolder_2"])
        let memo_3 = RealmMemo.init(value: ["contents" : "contents_3", "placeHolder": "placeHolder_3"])
        
        memo_2.isFavorite = true
        memo_3.isFavorite = true
        
        manager.addMemo(memo_1)
        manager.addMemo(memo_2)
        manager.addMemo(memo_3)
        
        XCTAssertEqual(2, manager.getMemoCount(withType: .favorite))
    }
    
    //  Memo delete
    
    //  Memo add from clipboard
    
    //  update memo set favorite
    
}

/**
 * Private Methods
 */
 
extension MemoRealmTests {
   
    func deleteAllMemos() {
        
        let realm = try! Realm()
        
        var config = Realm.Configuration()
        
        config.schemaVersion = 0
        
        try! realm.write {
            realm.deleteAll()
        }

    }
}
