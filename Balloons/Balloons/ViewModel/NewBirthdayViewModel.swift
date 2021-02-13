//
//  NewBirthdayViewModel.swift
//  Balloons
//
//  Created by Brena Amorim on 11/02/21.
//

import Foundation

class NewBirthdayViewModel: NewBirthdayViewModelProtocol {

    var birthdayData: Birthday?
    
    var birthdayRepository = BirthdayRepository(managedObjectContext: CoreDataStack.shared.mainContext, coreDataStack: CoreDataStack.shared)

    func saveBirthday(birthday: BirthdayBiding) -> Bool {
        return self.birthdayRepository.create(data: birthday)
    }
    
    func updateBirthday(birthday: Birthday, birthdayUpdate: BirthdayBiding) -> Bool {
        return self.birthdayRepository.update(model: birthday, newData: birthdayUpdate)
    }

}
