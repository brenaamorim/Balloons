//
//  NewBirthdayViewModelTests.swift
//  BalloonsTests
//
//  Created by Brena Amorim on 12/02/21.
//

import XCTest
@testable import Balloons
import CoreData

class NewBirthdayViewModelTests: XCTestCase {

    var coreDataStack: CoreDataStack!
    var birthdayRepository: BirthdayRepository!
    var newBirthdayViewModel: NewBirthdayViewModel!
    
    let dataBirthday = BirthdayBiding(photo: (UIImage(named: "emojiBirthday")?.pngData())!, name: "Joao", birth: Date(), phoneNumber: "8512345678")
    
    // Setting up Core Data Stack for tests
    override func setUp() {
        super.setUp()

        coreDataStack = TestCoreDataStack()
        birthdayRepository = BirthdayRepository(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)

        newBirthdayViewModel = NewBirthdayViewModel()
        newBirthdayViewModel.birthdayRepository = BirthdayRepository(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }

    override func tearDown() {
        coreDataStack = nil
        birthdayRepository = nil
        super.tearDown()
    }
    
    func test_saveBirthday_returnsTrue() {
        //given
        let birthdayBiding = dataBirthday
        
        //when
        let sut = newBirthdayViewModel.saveBirthday(birthday: birthdayBiding)
        
        //then
        XCTAssertTrue(sut)
    }

    func test_updateBirthday_returnsTrue() {
        //given
        let newBirthday = newBirthdayViewModel.saveBirthday(birthday: dataBirthday)
        let readBirthday = birthdayRepository.readAll()
        let newData = BirthdayBiding(photo: (UIImage(named: "emojiBirthday")?.pngData())!, name: "Antônio", birth: Date(), phoneNumber: "8512345678")
        
        //when
        let sut = newBirthdayViewModel.updateBirthday(birthday: readBirthday[0], birthdayUpdate: newData)
        
        //then
        XCTAssertTrue(newBirthday)
        XCTAssertTrue(sut)
    }

}
