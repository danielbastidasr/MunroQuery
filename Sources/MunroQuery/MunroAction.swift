//
//  MunroAction.swift
//  
//
//  Created by Daniel Bastidas Ramirez on 27/02/2021.
//

internal enum Action: Equatable{
    case orderByHeight(Order)
    case orderByName(Order)
    
    // Value determine if action was duplicated with a different value
    var value: QueryActionError{
        switch self {
        case .orderByHeight(_):
            return .OrderByHeight
        case .orderByName(_):
            return .OrderByName
        }
    }
}

public enum Order {
    case ASC
    case DES
}

public enum QueryActionError: Equatable, Error {
    case EmptyListInitialiser
    
    case OrderByHeight
    case OrderByName
}
