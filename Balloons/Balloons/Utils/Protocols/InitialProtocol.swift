//
//  InitialViewProtocol.swift
//  Balloons
//
//  Created by Brena Amorim on 11/02/21.
//

import Foundation

protocol InitialViewModelProtocol {
//r    func getAllCellsData() -> [Birthday]
    func calculateAge(year: Int) -> Int
    func reloadDataSource() -> [Birthday]
}
