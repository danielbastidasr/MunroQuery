//
//  MunroQueryBuilder.swift
//  
//
//  Created by Daniel Bastidas Ramirez on 27/02/2021.
//

public struct MunroQueryBuilder<Item: MunroItemType> {
    
    private let list: [Item]
    
    
    /// Initialise Builder with the only required parameter
    /// - Parameter listOfMunroItem: [MunroItem]
    /// - Throws: EmptyListInitialiser when list is empty
    public init(for listOfMunroItem: [Item]) throws{
        if listOfMunroItem.isEmpty {
            throw QueryActionError.EmptyListInitialiser
        }
        self.list = listOfMunroItem
    }
    
    /// Build will merge all queries used with the builder pattern.
    /// - Returns: MunroQuery
    public func build() -> MunroQuery<Item>{
        return .init(listOfMunroItem: list)
    }
}

public enum QueryActionError: Equatable, Error {
    case EmptyListInitialiser
}
