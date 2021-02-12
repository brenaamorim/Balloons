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

//    func numberOfRows() -> Int {
//        return self.birthdayRepository.readAll().count
//    }
    
//    func getAllCellsData() -> [Birthday] {
//        return self.birthdayRepository.readAll()
//    }

    func reloadDataSource() -> [Birthday] {
        return self.birthdayRepository.readAll()
    }

}
