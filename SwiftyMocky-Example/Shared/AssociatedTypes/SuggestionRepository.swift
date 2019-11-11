//
//  SuggestionRepository.swift
//  SwiftyMocky
//
//  Created by Andrzej Michnia on 11/11/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

//sourcery: AutoMockable
//sourcery: typealias = "Entity = Suggestion"
protocol SuggestionRepository: Repository where Entity == Suggestion {}

//sourcery: AutoMockable
//sourcery: associatedtype = "Entity: SuggestionProtocol"
protocol SuggestionRepositoryConstrainedToProtocol: Repository where Entity: SuggestionProtocol {}

protocol Repository {
  associatedtype Entity: EntityType

  func save(entity: Entity) -> Bool
  func save(entities: [Entity]) -> Bool

  func find(
    where predicate: NSPredicate,
    sortedBy sortDescriptors: [NSSortDescriptor]) -> [Entity]

  func findOne(where predicate: NSPredicate) -> Entity
  func delete(entity: Entity) -> Bool
  func delete(entities: [Entity]) -> Bool
}

protocol EntityType {}

protocol SuggestionProtocol: EntityType, AutoMockable { }

class Suggestion: SuggestionProtocol {
    init() {}
}
