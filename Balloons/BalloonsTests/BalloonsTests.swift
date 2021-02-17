//
//  BalloonsTests.swift
//  BalloonsTests
//
//  Created by Brena Amorim on 12/02/21.
//

import XCTest
@testable import Balloons

class BalloonsTests: XCTestCase {
    
    // Initial View
    func testInitialView_init() {
        let sut = InitialView(frame: UIScreen.main.bounds)
        XCTAssertNotNil(sut, "Não conseguiu inicializar a Initial View")
    }
    
    // Birthday View
    func testNewBirthdayView_init() {
        let sut = NewBirthdayView(frame: UIScreen.main.bounds)
        XCTAssertNotNil(sut, "Não conseguiu inicializar a NewBirthday View")
    }

}
