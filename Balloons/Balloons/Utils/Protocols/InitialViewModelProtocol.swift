//
//  InitialViewProtocol.swift
//  Balloons
//
//  Created by Brena Amorim on 11/02/21.
//

import Foundation

protocol InitialViewModelProtocol {
    func getCellData(forIndex index: Int, birthdays: [Birthday]) -> Birthday?
    func calculateAge(year: Int) -> Int
    func reloadDataSource() -> [Birthday]
    func deleteBirthday(identifier: String) -> Bool
}
