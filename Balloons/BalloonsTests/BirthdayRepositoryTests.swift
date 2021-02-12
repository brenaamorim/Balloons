//
//  BirthdayRepositoryTests.swift
//  BalloonsTests
//
//  Created by Brena Amorim on 12/02/21.
//

import XCTest
@testable import Balloons
import CoreData

class BirthdayRepositoryTests: XCTestCase {

    var coreDataStack: CoreDataStack!
    var birthdayRepository: BirthdayRepository!

    let dataBirthday = BirthdayBiding(photo: (UIImage(named: "emojiBirthday")?.pngData())!, name: "Joao", birth: Date(), phoneNumber: "8512345678")

    // Setting up Core Data Stack for tests
    override func setUp() {
        super.setUp()
        coreDataStack = TestCoreDataStack()
        birthdayRepository = BirthdayRepository(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    }

    override func tearDown() {
        coreDataStack = nil
        birthdayRepository = nil
        super.tearDown()
    }
    
    func test_createBirthday_returnsTrue() {
        //given
        let birthdayBiding = dataBirthday
        
        //when
        let sut = birthdayRepository.create(data: birthdayBiding)
        
        //then
        XCTAssertTrue(sut)
    }

    func testRootContextIsSavedAfterAddingHabit() {
        //creates a background context and a new instance of BirthdayRepository which uses that context
        let derivedContext = coreDataStack.newDerivedContext()
        birthdayRepository = BirthdayRepository(managedObjectContext: derivedContext, coreDataStack: coreDataStack)
        
        //creates an expectation that sends a signal to the test case when the Core Data Stack sends an NSManagedObjectContextDidSave notification event.
        expectation(forNotification: .NSManagedObjectContextDidSave, object: coreDataStack.mainContext) { _ in
            return true
        }
        
        //it adds a new birthday inside a perform(_:) block. Executed asynchronously
        derivedContext.perform {
            let newBirthday = self.birthdayRepository.create(data: self.dataBirthday)

            XCTAssertNotNil(newBirthday)
        }
        
        //The test waits for the signal that the habit saved. The test fails if it waits longer than two seconds.
        waitForExpectations(timeout: 2.0) { error in
            XCTAssertNil(error, "Save did not occur")
        }
    }
    //testing if the data saves to the persistent store
    
    func test_readAll_returnsFirstBirthday() {
        //given
        let newBirthday = birthdayRepository.create(data: dataBirthday)
        
        //when
        let sut = birthdayRepository.readAll()
        
        //then
        XCTAssertTrue(newBirthday)
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut[0].name, dataBirthday.name)
    }
    
    func test_read_returnsName() {
        //given
        let newBirthday = birthdayRepository.create(data: dataBirthday)
        let readBirthdays = birthdayRepository.readAll()
        
        //when
        let sut = birthdayRepository.read(identifier: readBirthdays[0].id!)
        
        //then
        XCTAssertTrue(newBirthday)
        XCTAssertNotNil(readBirthdays)
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut!.name, dataBirthday.name)
    }
    
    func test_read_returnsNil() {
        //given
        let identifier = "0x6000028d7c60 <x-coredata://CF3A0B68-28D8-4A34-A17E-DDB499BCB502/Birthday/p1>"
        
        //when
        let sut = birthdayRepository.read(identifier: identifier)

        //then
        XCTAssertNil(sut)
    }

    func test_readAll_returnsNil() {
        //when
        let sut = birthdayRepository.readAll()

        //then
        XCTAssertEqual(sut, [])
    }

    func test_update_returnsTrue() {
        //given
        let newBirthday = birthdayRepository.create(data: dataBirthday)
        let readBirthdays = birthdayRepository.readAll()
        let newData = BirthdayBiding(photo: (UIImage(named: "emojiBirthday")?.pngData())!, name: "Maria", birth: Date(), phoneNumber: "8512345678")
        //when
        let sut = birthdayRepository.update(model: readBirthdays[0], newData: newData)

        //then
        XCTAssertTrue(newBirthday)
        XCTAssertNotNil(readBirthdays)
        XCTAssertTrue(sut)
    }

    func test_delete_returnsTrue() {
        let newBirthday = birthdayRepository.create(data: dataBirthday)
        let readBirthdays = birthdayRepository.readAll()
        
        //when
        let sut = birthdayRepository.delete(identifier: readBirthdays[0].id!)
        
        //then
        XCTAssertTrue(newBirthday)
        XCTAssertNotNil(readBirthdays)
        XCTAssertTrue(sut)
    }

}
