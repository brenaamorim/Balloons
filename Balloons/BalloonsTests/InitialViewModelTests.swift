//
//  InitialViewModelTests.swift
//  BalloonsTests
//
//  Created by Brena Amorim on 12/02/21.
//

import XCTest
@testable import Balloons
import CoreData

class InitialViewModelTests: XCTestCase {

    var coreDataStack: CoreDataStack!
    var birthdayRepository: BirthdayRepository!
    var initialBirthdayViewModel: InitialViewModel!
    
    let dataBirthday = BirthdayBiding(photo: (UIImage(named: "emojiBirthday")?.pngData())!, name: "Joao", birth: Date(), phoneNumber: "8512345678")
    
    // Setting up Core Data Stack for tests
    override func setUp() {
        super.setUp()

        coreDataStack = TestCoreDataStack()
        birthdayRepository = BirthdayRepository(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)

        initialBirthdayViewModel = InitialViewModel()
        initialBirthdayViewModel.birthdayRepository = BirthdayRepository(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }
    
    func test_calculateAge_returnsInt() {
        //given
        let birthYear = 2000

        //when
        let sut = initialBirthdayViewModel.calculateAge(year: birthYear)
        
        //then
        XCTAssertEqual(sut, 21)
    }
    
    func test_reloadDataSource_returnsFirstResult() {
        //given
        _ = birthdayRepository.create(data: dataBirthday)

        //when
        let sut = initialBirthdayViewModel.reloadDataSource()
        
        //then
        XCTAssertEqual(sut[0].name, dataBirthday.name)
        
    }
    
    func test_getCellData_returnsBirthdayData() {
        //given
        _ = birthdayRepository.create(data: dataBirthday)
        let birthdays = initialBirthdayViewModel.reloadDataSource()
        
        //when
        let sut = initialBirthdayViewModel.getCellData(forIndex: 0, birthdays: birthdays)
        
        //then
        XCTAssertNotNil(birthdays)
        XCTAssertEqual(sut!.name, dataBirthday.name)
    }
    
    func test_deleteBirthday_returnsTrue() {
        //given
        _ = birthdayRepository.create(data: dataBirthday)
        let birthdays = initialBirthdayViewModel.reloadDataSource()
        
        //when
        let sut = initialBirthdayViewModel.deleteBirthday(identifier: birthdays[0].id!)
        
        //then
        XCTAssertNotNil(birthdays)
        XCTAssertTrue(sut)
    }

}
