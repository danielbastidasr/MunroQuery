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

    /// Build will merge all queries used with the builder pattern.
    /// - Returns: MunroQuery
    public func build() -> MunroQuery<Item>{
        return .init(listOfMunroItem: list, actions: actions )
    }
    
    /// Sort by Height given an Order
    /// - Parameter order: can be ASC = ascendent  or DES = descendent
    /// - Throws: SortByHeight when trying to duplicate the query
    /// - Returns: A valid MunroQueryBuilder adding sortByHeight action
    public func sortByHeight(_ order :Order) throws -> MunroQueryBuilder {
        try addActionToBuilder(
            action: .sortByHeight(order)
        )
    }
    
    /// Sort by Name given an Order
    /// - Parameter order: can be ASC = ascendent  or DES = descendent
    /// - Throws: SortByName when trying to duplicate the query
    /// - Returns: A valid MunroQueryBuilder adding sortByName action
    public func sortByName(_ order :Order) throws -> MunroQueryBuilder {
        try addActionToBuilder(
            action: .sortByName(order)
        )
    }
    
    
    /// Filter by Munro category
    /// - Parameter category: MUNRO or TOP
    /// - Throws: FilterByCategory when trying to duplicate query
    /// - Returns: A valid MunroQueryBuilder adding filterBy action
    public func filterBy(_ category :MunroCategory) throws -> MunroQueryBuilder {
        return try addActionToBuilder(
            action: .filterBy(category)
        )
    }
    
    
    /// Filter by Min height value
    /// - Parameter number: Min height value
    /// - Throws: MinHeight when trying to duplicate query
    /// - Returns: A valid MunroQueryBuilder adding minHeight action
    public func minHeight(of number: Double) throws -> MunroQueryBuilder{
        // should not be superior to MAX Height
        try self.actions.forEach { action in
            if (action.value == .MaxHeigh){
                switch action {
                case .maxHeight(let height):
                    try checkMinAndMaxBoundaries(minValue: number, maxValue: height)
                default:
                    break
                }
            }
        }
        
        return try addActionToBuilder(
            action: .minHeight(number)
        )
    }
    
    /// Filter by Min height value
    /// - Parameter number: Max height value
    /// - Throws: MaxHeight when trying to duplicate query
    /// - Returns: A valid MunroQueryBuilder adding maxHeight action
    public func maxHeight(of number: Double) throws -> MunroQueryBuilder{
        // should not be inferior to MIN Height
        try self.actions.forEach { action in
            if (action.value == .MinHeight){
                switch action {
                case .minHeight(let height):
                    try checkMinAndMaxBoundaries(minValue: height, maxValue: number)
                default:
                    break
                }
            }
        }
        
        return try addActionToBuilder(
            action: .maxHeight(number)
        )
    }
    
    /// Limit query to number of results
    /// - Parameter number: max final number of results
    /// - Throws: LimitNumberOutOfBoundaries (when number is not correct value) or LimitNumber (when query duplicated)
    /// - Returns: A valid MunroQueryBuilder adding limitResults action
    public func limitResults(to number: Int) throws -> MunroQueryBuilder{
        if number < 0 {
            throw QueryActionError.LimitNumberOutOfBoundaries
        }
        return try addActionToBuilder(
            action:.limitTo(number)
        )
    }
}
extension MunroQueryBuilder{
    
    private init(for listOfMunroItem: [Item], actions: [Action]){
        self.list = listOfMunroItem
        self.actions = actions
    }
    
    private func addActionToBuilder(action: Action) throws -> MunroQueryBuilder{
        let storedActions = self.actions.map { action in
            return action.value
        }
        if storedActions.contains(action.value) {
            throw action.value
        }
        
        var newActions: [Action] = self.actions
        newActions.append(
            action
        )
        return .init(for: list, actions: newActions)
    }
    
    private func checkMinAndMaxBoundaries(minValue: Double, maxValue: Double) throws{
        if maxValue < minValue{
            throw QueryActionError.MixMaxHeightOutOfBoundaries
        }
    }
}
