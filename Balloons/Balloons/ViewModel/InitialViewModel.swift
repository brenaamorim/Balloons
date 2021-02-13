//
//  InitialViewModel.swift
//  Balloons
//
//  Created by Brena Amorim on 11/02/21.
//

import UIKit

class InitialViewModel: InitialViewModelProtocol {

    var birthdayRepository = BirthdayRepository(managedObjectContext: CoreDataStack.shared.mainContext, coreDataStack: CoreDataStack.shared)
    
    func calculateAge(year: Int) -> Int {
        let calendar = Calendar.current
        let currentYear = Int(calendar.component(.year, from: Date()))

        return Int(currentYear - year)
    }
    
    func getCellData(forIndex index: Int, birthdays: [Birthday]) -> Birthday? {
        guard let birthdayId = birthdays[index].id else { return nil }
        
        return self.birthdayRepository.read(identifier: birthdayId)
    }
    
    func reloadDataSource() -> [Birthday] {
        return self.birthdayRepository.readAll()
    }
    
    func deleteBirthday(identifier: String) -> Bool {
        return self.birthdayRepository.delete(identifier: identifier)
    }

}
