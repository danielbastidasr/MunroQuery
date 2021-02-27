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
    case maxHeight(Double)
    
    case limitTo(Int)
    
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
        case .maxHeight(_):
            return .MaxHeigh
        case .limitTo(_):
            return .LimitNumber
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
    case MaxHeigh
    
    case LimitNumber
    
    case LimitNumberOutOfBoundaries
    case MixMaxHeightOutOfBoundaries
}
