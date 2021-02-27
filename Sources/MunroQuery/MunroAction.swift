//
//  MunroAction.swift
//  
//
//  Created by Daniel Bastidas Ramirez on 27/02/2021.
//

internal enum Action: Equatable{
    case sortByHeight(Order)
    case sortByName(Order)
    
    case filterBy(MunroCategory)
    
    case minHeight(Double)
    
    // Value determine if action was duplicated with a different value
    var value: QueryActionError{
        switch self {
        case .sortByHeight(_):
            return .SortByHeight
        case .sortByName(_):
            return .SortByName
        case .filterBy(_):
            return .FilterByCategory
        case .minHeight(_):
            return .MinHeight
        }
    }
}

public enum Order {
    case ASC
    case DES
}

public enum QueryActionError: Equatable, Error {
    case EmptyListInitialiser
    
    case SortByHeight
    case SortByName
    
    case FilterByCategory
    
    case MinHeight
}
