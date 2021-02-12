//
//  InitialViewModel.swift
//  Balloons
//
//  Created by Brena Amorim on 11/02/21.
//

import UIKit

class InitialViewModel: InitialViewModelProtocol {
    func calculateAge(year: Int) -> Int {
        let calendar = Calendar.current
        let currentYear = Int(calendar.component(.year, from: Date()))
        return Int(currentYear - year)
    }

    let birthdayRepository = BirthdayRepository(managedObjectContext: CoreDataStack.shared.mainContext, coreDataStack: CoreDataStack.shared)

    func numberOfRows() -> Int {
        return self.birthdayRepository.readAll().count
    }
    
    func getAllCellsData() -> [Birthday] {
        return self.birthdayRepository.readAll()
    }

}
