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
    
    func testGenerateUUIDNotEqual() {
        
        let memo_1 = "ABC".encryption()
        let memo_2 = "DEF".encryption()

        XCTAssertNotEqual(memo_1, memo_2)
    }
}
