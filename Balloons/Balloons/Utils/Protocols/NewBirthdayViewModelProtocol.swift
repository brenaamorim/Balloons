//
//  NewBirthdayProtocol.swift
//  Balloons
//
//  Created by Brena Amorim on 11/02/21.
//

import Foundation

protocol NewBirthdayViewModelProtocol {
    func saveBirthday(birthday: BirthdayBiding) -> Bool
    func updateBirthday(birthday: Birthday, birthdayUpdate: BirthdayBiding) -> Bool
}
