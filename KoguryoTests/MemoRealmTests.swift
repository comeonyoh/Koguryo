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
        
        self.deleteAllMemos()

    }
    
    override func tearDown() {
        
        super.tearDown()
        
        self.deleteAllMemos()
    }
    
    //  Memo add
    
    func testMemoAdd() {
        
        let manager = MemoManager.init()
        
        let memo = RealmMemo.init(value: ["contents" : "contents", "placeHolder": "placeHolder", "memoId" : "contents".encryption()])

        manager.addMemo(memo)
        
        XCTAssertEqual(1, manager.getMemoCount(withType: .normal))
    }
    
    func testMemosAdd() {
        
        let manager = MemoManager.init()
        
        let memo_1 = RealmMemo.init(value: ["contents" : "contents_1", "placeHolder": "placeHolder_1", "memoId" : "contents_1".encryption()])
        let memo_2 = RealmMemo.init(value: ["contents" : "contents_2", "placeHolder": "placeHolder_2", "memoId" : "contents_2".encryption()])
        let memo_3 = RealmMemo.init(value: ["contents" : "contents_3", "placeHolder": "placeHolder_3", "memoId" : "contents_3".encryption()])
        
        manager.addMemo(memo_1)
        manager.addMemo(memo_2)
        manager.addMemo(memo_3)
        
        XCTAssertEqual(3, manager.getMemoCount(withType: .normal))
    }

    //  Favorite memo count
    func testCountFavoriteMemos() {

        let manager = MemoManager.init()
        
        let memo_1 = RealmMemo.init(value: ["contents" : "contents_1", "placeHolder": "placeHolder_1", "memoId" : "contents_1".encryption()])
        let memo_2 = RealmMemo.init(value: ["contents" : "contents_2", "placeHolder": "placeHolder_2", "memoId" : "contents_2".encryption()])
        let memo_3 = RealmMemo.init(value: ["contents" : "contents_3", "placeHolder": "placeHolder_3", "memoId" : "contents_3".encryption()])
        
        memo_2.isFavorite = true
        memo_3.isFavorite = true
        
        manager.addMemo(memo_1)
        manager.addMemo(memo_2)
        manager.addMemo(memo_3)
        
        XCTAssertEqual(3, manager.getMemoCount(withType: .normal))
        XCTAssertEqual(2, manager.getMemoCount(withType: .favorite))
    }
    
    //  Memo delete
    func testDeleteMemo() {
       
        let manager = MemoManager.init()
        
        let memo_1 = RealmMemo.init(value: ["contents" : "contents_1", "placeHolder": "placeHolder_1", "memoId" : "contents_1".encryption()])
        let memo_2 = RealmMemo.init(value: ["contents" : "contents_2", "placeHolder": "placeHolder_2", "memoId" : "contents_2".encryption()])
        let memo_3 = RealmMemo.init(value: ["contents" : "contents_3", "placeHolder": "placeHolder_3", "memoId" : "contents_3".encryption()])
        let memo_4 = RealmMemo.init(value: ["contents" : "contents_4", "placeHolder": "placeHolder_4", "memoId" : "contents_4".encryption()])
        let memo_5 = RealmMemo.init(value: ["contents" : "contents_5", "placeHolder": "placeHolder_5", "memoId" : "contents_5".encryption()])
        
        manager.addMemo(memo_1)
        manager.addMemo(memo_2)
        manager.addMemo(memo_3)
        manager.addMemo(memo_4)
        manager.addMemo(memo_5)

        XCTAssertEqual(5, manager.getMemoCount(withType: .normal))
        
        manager.deleteMemo(withMemo: memo_1)
        
        XCTAssertEqual(4, manager.getMemoCount(withType: .normal))
    }
    
    //  get Memo with Index
    func testGetMemoAtIndex() {
        
        let manager = MemoManager.init()
        
        let memo_1 = RealmMemo.init(value: ["contents" : "contents_1", "placeHolder": "placeHolder_1", "memoId" : "contents_1".encryption()])
        let memo_2 = RealmMemo.init(value: ["contents" : "contents_2", "placeHolder": "placeHolder_2", "memoId" : "contents_2".encryption()])
        let memo_3 = RealmMemo.init(value: ["contents" : "contents_3", "placeHolder": "placeHolder_3", "memoId" : "contents_3".encryption()])
        let memo_4 = RealmMemo.init(value: ["contents" : "contents_4", "placeHolder": "placeHolder_4", "memoId" : "contents_4".encryption()])

        memo_4.isFavorite = true

        manager.addMemo(memo_1)
        manager.addMemo(memo_2)
        manager.addMemo(memo_3)
        manager.addMemo(memo_4)

        let getMemo = manager.getMemoAt(1, withType: .normal)
        
        XCTAssertEqual(getMemo, memo_3)
        XCTAssertEqual(manager.getMemoAt(0, withType: .favorite), memo_4)
        
        let m_memo_1 = manager.getMemoAt(IndexPath.init(row: 0, section: MemoListSection.list.rawValue))
        
        XCTAssertEqual(m_memo_1, memo_4)
        XCTAssertEqual(manager.getMemoAt(IndexPath.init(row: 0, section: MemoListSection.favorite.rawValue)), memo_4)
        
    }
    
    //  Memo add from clipboard
    
    //  update memo set favorite
 
    //  update memo contents and placeholder
    func testModifyMemoAtIndex() {
        
        let manager = MemoManager.init()
        
        let memo_1 = RealmMemo.init(value: ["contents" : "contents_1", "placeHolder": "placeHolder_1", "memoId" : "contents_1".encryption()])
        
        manager.addMemo(memo_1)
        
        let newInfo = ["contents" : "modified_contents", "placeHolder" : "modified_placeholder"]
        XCTAssertEqual(manager.getMemoCount(withType: .normal), 1)

        manager.updateMemo(withMemoId: memo_1.memoId, withNewInfo: newInfo)
        
        let modifiedMemo = manager.getMemoAt(0, withType: .normal)
        
        XCTAssertEqual(modifiedMemo.contents, newInfo["contents"])
        XCTAssertEqual(manager.getMemoCount(withType: .normal), 1)

    }

}





/**
 * Private Methods
 */
 
extension MemoRealmTests {
   
    fileprivate func deleteAllMemos() {
        
        let realm = try! Realm()
        
        var config = Realm.Configuration()
        
        config.schemaVersion = 0
        
        try! realm.write {
            realm.deleteAll()
        }

    }
}
