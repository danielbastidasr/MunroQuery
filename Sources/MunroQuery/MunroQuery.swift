//
//  MunroQuery.swift
//
//
//  Created by Daniel Bastidas Ramirez on 27/02/2021.
//

public struct MunroQuery<Item: MunroItemType>: Equatable {
    private let list: [Item]
    private var actions: [Action]
    
    init(listOfMunroItem: [Item], actions: [Action]) {
        self.list = listOfMunroItem
        self.actions = actions
    }
    
    /// Execute Query
    /// - Returns: List result of applying the Query
    public func execute() -> [Item]{
        return executeQueries(list: list)
    }
    
    private func executeQueries(list: [Item]) -> [Item]{
        var finalList: [Item] = list.filter { item -> Bool in
            item.category != nil
        }
        if !actions.isEmpty{
            finalList = executeAction(actions[0], list: finalList)
        }
        return finalList
    }
    
    private func executeAction(_ action: Action, list: [Item]) -> [Item]{
        switch action {
        case .orderByHeight(let order):
            return sortByHeight(list: list, order)
        case .orderByName(let order):
            return sortByName(list: list, order)
        }
    }
}
extension MunroQuery{
    // MARK: - Actions
    private func sortByHeight(list: [Item], _ order: Order) -> [Item]{
        return list.sorted { (left, right) -> Bool in
            switch order {
            case .ASC:
                return left.height < right.height
            case .DES:
                return left.height > right.height
            }
        }
    }
    
    private func sortByName(list: [Item], _ order: Order) -> [Item]{
        return list.sorted { (left, right) -> Bool in
            switch order {
            case .ASC:
                return left.name < right.name
            case .DES:
                return left.name > right.name
            }
        }
    }
}
