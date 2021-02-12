//
//  NewBirthdayViewModel.swift
//  Balloons
//
//  Created by Brena Amorim on 11/02/21.
//

import Foundation

class NewBirthdayViewModel: NewBirthdayViewModelProtocol {
    
    private let birthdayRepository = BirthdayRepository(managedObjectContext: CoreDataStack.shared.mainContext, coreDataStack: CoreDataStack.shared)

    func saveBirthday(birthday: BirthdayBiding) -> Bool {
        return self.birthdayRepository.create(data: birthday)
    }
    
    func updateBirthday(birthday: Birthday) -> Bool {
        return self.birthdayRepository.update(model: birthday)
    }
    
    func reloadDataSource() -> [Birthday] {
        return self.birthdayRepository.readAll()
    }

}
