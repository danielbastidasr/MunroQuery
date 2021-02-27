//
//  MunroQuery.swift
//
//
//  Created by Daniel Bastidas Ramirez on 27/02/2021.
//

public struct MunroQuery<Item: MunroItemType>: Equatable {
    private let list: [Item]
    
    init(listOfMunroItem: [Item]) {
        self.list = listOfMunroItem
    }
    
    /// Execute Query
    /// - Returns: List result of applying the Query
    public func execute() -> [Item]{
        let finalList: [Item] = list.filter { item -> Bool in
            item.category != nil
        }
        return finalList
    }
}
