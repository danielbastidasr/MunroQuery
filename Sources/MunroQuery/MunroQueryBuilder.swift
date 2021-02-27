//
//  MunroQueryBuilder.swift
//  
//
//  Created by Daniel Bastidas Ramirez on 27/02/2021.
//

public struct MunroQueryBuilder<Item: MunroItemType> {
    
    private let list: [Item]
    
    public init(for listOfMunroItem: [Item]) throws{
        if listOfMunroItem.isEmpty {
            throw QueryActionError.EmptyListInitialiser
        }
        self.list = listOfMunroItem
    }
}

public enum QueryActionError: Equatable, Error {
    case EmptyListInitialiser
}
