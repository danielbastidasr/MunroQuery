//
//  MunroQueryBuilder.swift
//  
//
//  Created by Daniel Bastidas Ramirez on 27/02/2021.
//

public struct MunroQueryBuilder<Item: MunroItemType> {
    
    private let list: [Item]
    private var actions: [Action]
    
    /// Initialise Builder with the only required parameter
    /// - Parameter listOfMunroItem: [MunroItem]
    /// - Throws: EmptyListInitialiser when list is empty
    public init(for listOfMunroItem: [Item]) throws{
        if listOfMunroItem.isEmpty {
            throw QueryActionError.EmptyListInitialiser
        }
        self.list = listOfMunroItem
        self.actions = []
    }
    
    private init(for listOfMunroItem: [Item], actions: [Action]){
        self.list = listOfMunroItem
        self.actions = actions
    }
    
    /// Build will merge all queries used with the builder pattern.
    /// - Returns: MunroQuery
    public func build() -> MunroQuery<Item>{
        return .init(listOfMunroItem: list, actions: actions )
    }
    
    public func sortByHeight(_ order :Order) throws -> MunroQueryBuilder {
        let storedActions = self.actions.map { action in
            return action.value
        }
        
        let action = Action.orderByHeight(order)
        if storedActions.contains(action.value) {
            throw action.value
        }
        
        var newActions: [Action] = self.actions
        newActions.append(
            action
        )
        return .init(for: list, actions: newActions)
    }
}

public enum QueryActionError: Equatable, Error {
    case EmptyListInitialiser
    
    case OrderByHeight
}


public enum Order {
    case ASC
    case DES
}


internal enum Action: Equatable{
    case orderByHeight(Order)
    
    var value: QueryActionError{
        switch self {
        case .orderByHeight(_):
            return .OrderByHeight
        }
    }
}
