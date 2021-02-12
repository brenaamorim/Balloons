//
//  RepositoryProtocol.swift
//  Balloons
//
//  Created by Brena Amorim on 10/02/21.
//
//swiftlint:disable type_name

import Foundation

protocol RepositoryProtocol {
    associatedtype T
    associatedtype A

    func create(data: A) -> Bool
    func read(identifier: String) -> T?
    func readAll() -> [T]
    func update(model: T) -> Bool
    func delete(identifier: String) -> Bool
}
