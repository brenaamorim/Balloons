//
//  BirthdayRepository.swift
//  Balloons
//
//  Created by Brena Amorim on 11/02/21.
//
//swiftlint:disable type_name

import Foundation
import CoreData

class BirthdayRepository: RepositoryProtocol {
    
    typealias T = Birthday
    typealias A = BirthdayBiding
    
    let managedObjectContext: NSManagedObjectContext
    let coreDataStack: CoreDataStack
    
    public init(managedObjectContext: NSManagedObjectContext, coreDataStack: CoreDataStack) {
        self.managedObjectContext = managedObjectContext
        self.coreDataStack = coreDataStack
    }
    
    func create(data: BirthdayBiding) -> Bool {
        guard let birthday = NSEntityDescription.insertNewObject(forEntityName: "Birthday", into: coreDataStack.mainContext) as? Birthday else { return false }
        
        birthday.id = UUID().uuidString
        birthday.photo = data.photo
        birthday.name = data.name
        birthday.birthDate = data.birth
        birthday.phoneNumber = data.phoneNumber
        
        do {
            try coreDataStack.mainContext.save()
            return true
        } catch let error as NSError {
            print("Error: \(error), description: \(error.userInfo)")
            return false
        }
    }
    
    func read(identifier: String) -> Birthday? {
        let birthdayFetchRequest: NSFetchRequest<Birthday> = Birthday.fetchRequest()
        birthdayFetchRequest.predicate = NSPredicate(format: "id == %@", identifier)
        
        do {
            let result = try
                managedObjectContext.fetch(birthdayFetchRequest)
            if result.count > 0 {
                if let birthday = result.first { return birthday } else {
                    return nil
                }
            } else {
                return nil
            }
            
        } catch let error as NSError {
            print("Error: \(error) description: \(error.userInfo)")
            return nil
        }
    }
    
    func readAll() -> [Birthday] {
        let birthdayFetchRequest: NSFetchRequest<Birthday> = Birthday.fetchRequest()
        
        do {
            let results = try managedObjectContext.fetch(birthdayFetchRequest)
            if results.count > 0 { //found a birthday
                return results
            } else { //birthday not found
                return []
            }
        } catch let error as NSError {
            print("Error: \(error) description: \(error.userInfo)")
            return []
        }
    }
    
    func update(model: Birthday, newData: BirthdayBiding) -> Bool {
        let birthdayFetchRequest: NSFetchRequest<Birthday> = Birthday.fetchRequest()
        birthdayFetchRequest.predicate = NSPredicate(format: "id == %@", model.id!)
        
        do {
            let getBirthday = try coreDataStack.mainContext.fetch(birthdayFetchRequest)
            if getBirthday.count > 0 {
                let objectUpdate = getBirthday[0] as NSManagedObject
                objectUpdate.setValue(newData.photo, forKey: "photo")
                objectUpdate.setValue(newData.name, forKey: "name")
                objectUpdate.setValue(newData.birth, forKey: "birthDate")
                objectUpdate.setValue(newData.phoneNumber, forKey: "phoneNumber")
            } else {
                return false
            }
            do {
                try coreDataStack.mainContext.save()
                return true
            } catch let error as NSError {
                print(error)
                return false
            }
        } catch let error as NSError {
            
            print(error)
            return false
        }
    }
    
    func delete(identifier: String) -> Bool {
        let birthdayFetchRequest: NSFetchRequest<Birthday> = Birthday.fetchRequest()
        birthdayFetchRequest.predicate = NSPredicate(format: "id == %@", identifier)
        
        do {
            let getBirthday = try coreDataStack.mainContext.fetch(birthdayFetchRequest)
            //trying to fetch habit
            if getBirthday.count > 0 {
                let objectToDelete = getBirthday[0] as NSManagedObject
                coreDataStack.mainContext.delete(objectToDelete)
            } else {
                return false
            }
            
            do {
                try coreDataStack.mainContext.save()
                return true
            } catch let error as NSError {
                print("Error: \(error), description: \(error.userInfo)")
                return false
            }
        } catch let error as NSError {
            print(error)
            return false
        }
        
    }

}
