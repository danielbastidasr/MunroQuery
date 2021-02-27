//
//  MunroItemType.swift
//  
//
//  Created by Daniel Bastidas Ramirez on 27/02/2021.
//

public protocol MunroItemType: Equatable {
    var gridReference: String { get }
    var name: String { get }
    var height: Double { get }
    var category: MunroCategory? { get }
}
