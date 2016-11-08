//
//  KoguryoTests.swift
//  KoguryoTests
//
//  Created by KimJungSu on 11/7/16.
//  Copyright © 2016 ODOV. All rights reserved.
//

import XCTest
@testable import Koguryo

class KoguryoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSectionIndex() {
        
        XCTAssertEqual(0, MemoListSection.addButton.rawValue)
        XCTAssertEqual(1, MemoListSection.favorite.rawValue)
        XCTAssertEqual(2, MemoListSection.list.rawValue)
    }
 
    func testMemoEquality() {
        
        let first = Memo.init(memo: "Hello world")
        let second = Memo.init(memo: "Hello world", withPlaceHolder: "Say Hello")
        
        XCTAssertNotEqual(first, second)
    }
    
    func testHasFavoriteMember() {
        
        let memo = Memo.init(memo: "Test Memo")
        
        let manager = MemoManager.init()
        
        XCTAssertFalse(manager.hasFavoriteMemos())
        XCTAssertEqual(manager.favoriteMemos?.count, 0)
        
        XCTAssertTrue(manager.addFavoriteMemo(memo))
        
        XCTAssertTrue(manager.hasFavoriteMemos())
        XCTAssertEqual(manager.favoriteMemos?.count, 1)
    }
    
    func testFavoriteMemberOverflowThanMaxCount() {
        
        let memo_1 = Memo.init(memo: "Test Memo")
        let memo_2 = Memo.init(memo: "Test Memo")
        let memo_3 = Memo.init(memo: "Test Memo")
        let memo_4 = Memo.init(memo: "Test Memo")

        let manager = MemoManager.init()

        XCTAssertTrue(manager.addFavoriteMemo(memo_1))
        XCTAssertTrue(manager.addFavoriteMemo(memo_2))
        XCTAssertTrue(manager.addFavoriteMemo(memo_3))
        XCTAssertFalse(manager.addFavoriteMemo(memo_4))

    }
    
}


extension KoguryoTests {
    
    func testCopyFromPasteboard() {
        
        let testString = "I love soccer!"
        
        let pasteboard = UIPasteboard.general
        
        pasteboard.string = testString
        
        let manager = MemoManager.init()

        manager.copyFromPasteboard()
        
        XCTAssertEqual(manager.allOfMemos?.count, 1)
        XCTAssertEqual(manager.allOfMemos?.first?.contents, testString)
    }
}











