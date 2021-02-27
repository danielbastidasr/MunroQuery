import XCTest
@testable import MunroQuery

final class MunroQueryTests: XCTestCase {
    
    func test_createEmptyListQuery_Build_Shouldthrow() throws{
        // Given empty list
        let emtpyList: [ItemMock] = []
        
        // When creating Query empty list
        XCTAssertThrowsError(
            try MunroQueryBuilder(for: emtpyList)
        )
    }
    
    func test_createEmptyQuery_BuildAndExecute_ShouldReturnListWithoutNoneItem() throws {
        // Given list
        let listMunro: [ItemMock] = [
            ItemMock(gridReference: "ref1", name: "Name", height: 1000, category: .MUNRO, extraItem: 1),
            ItemMock(gridReference: "ref2", name: "Name", height: 1000, category: nil, extraItem: 2),
            ItemMock(gridReference: "ref3", name: "Name", height: 1000, category: .MUNRO, extraItem: 3),
            ItemMock(gridReference: "ref4", name: "Name", height: 1000, category: nil, extraItem: 4),
            ItemMock(gridReference: "ref5", name: "Name", height: 1000, category: .MUNRO, extraItem: 5)
        ]
        
        // When creating Query and Executing
        let builder: MunroQueryBuilder = try .init(for: listMunro)
        let sut = builder.build()
        
        // Then return MunroQuery
        XCTAssertEqual(sut.execute(),
                       [
                        ItemMock(gridReference: "ref1", name: "Name", height: 1000, category: .MUNRO, extraItem: 1),
                        ItemMock(gridReference: "ref3", name: "Name", height: 1000, category: .MUNRO, extraItem: 3),
                        ItemMock(gridReference: "ref5", name: "Name", height: 1000, category: .MUNRO, extraItem: 5)
                       ]
        )
    }
    
    // MARK:- Sorted By Height
    
    func test_createSortByHeightASC_BuildAndExecute_ShouldReturnListSortedByHeightASC() throws {
        // Given list
        let listMunro: [ItemMock] = [
            ItemMock(gridReference: "ref1", name: "Name", height: 1005, category: .MUNRO, extraItem: 1),
            ItemMock(gridReference: "ref2", name: "Name", height: 1004, category: nil, extraItem: 2),
            ItemMock(gridReference: "ref3", name: "Name", height: 1003, category: .MUNRO, extraItem: 3),
            ItemMock(gridReference: "ref4", name: "Name", height: 1002, category: nil, extraItem: 4),
            ItemMock(gridReference: "ref5", name: "Name", height: 1001, category: .MUNRO, extraItem: 5)
        ]
        
        // When creating Query and Executing
        let sut = try MunroQueryBuilder(for: listMunro)
            .sortByHeight(.ASC)
            .build()
        
        // Then return MunroQuery
        XCTAssertEqual(sut.execute(),
                       [
                        ItemMock(gridReference: "ref5", name: "Name", height: 1001, category: .MUNRO, extraItem: 5),
                        ItemMock(gridReference: "ref3", name: "Name", height: 1003, category: .MUNRO, extraItem: 3),
                        ItemMock(gridReference: "ref1", name: "Name", height: 1005, category: .MUNRO, extraItem: 1)
                       ]
        )
    }
    
    func test_createSortByHeightDESC_BuildAndExecute_ShouldReturnListSortedByHeightDESC() throws {
        // Given list
        let listMunro: [ItemMock] = [
            ItemMock(gridReference: "ref1", name: "Name", height: 1005, category: .MUNRO, extraItem: 1),
            ItemMock(gridReference: "ref4", name: "Name", height: 1002, category: nil, extraItem: 4),
            ItemMock(gridReference: "ref2", name: "Name", height: 1004, category: nil, extraItem: 2),
            ItemMock(gridReference: "ref5", name: "Name", height: 1001, category: .MUNRO, extraItem: 5),
            ItemMock(gridReference: "ref3", name: "Name", height: 1003, category: .MUNRO, extraItem: 3)
        ]

        // When creating Query and Executing
        let builder: MunroQueryBuilder = try .init(for: listMunro)
        let sut = try builder
            .sortByHeight(.DES)
            .build()

        // Then return MunroQuery
        XCTAssertEqual(sut.execute(),
                       [
                        ItemMock(gridReference: "ref1", name: "Name", height: 1005, category: .MUNRO, extraItem: 1),
                        ItemMock(gridReference: "ref3", name: "Name", height: 1003, category: .MUNRO, extraItem: 3),
                        ItemMock(gridReference: "ref5", name: "Name", height: 1001, category: .MUNRO, extraItem: 5)
                       ]
        )
    }
    
    func test_createSortByHeightDuplicate_BuildAndExecute_ShouldThrow() throws {
        // Given list
        let listMunro = createList()
        
        // When creating Builder with sortingByHeight
        let sut = try MunroQueryBuilder(for: listMunro)
            .sortByHeight(.ASC)
            
        // Then Throw Error buidling with
        XCTAssertThrowsError(
            try sut
                .sortByHeight(.DES)
        )
    }
    
    // MARK:- Sort by Name
    
    func test_createSortByNameASC_BuildAndExecute_ShouldReturnListSortedByNameASC() throws {
        // Given list
        let listMunro: [ItemMock] = [
            ItemMock(gridReference: "ref1", name: "Name5", height: 1000, category: .MUNRO, extraItem: 1),
            ItemMock(gridReference: "ref2", name: "Name4", height: 1000, category: .TOP, extraItem: 2),
            ItemMock(gridReference: "ref3", name: "Name3", height: 1000, category: .MUNRO, extraItem: 3),
            ItemMock(gridReference: "ref4", name: "Name1", height: 1000, category: .TOP, extraItem: 4),
            ItemMock(gridReference: "ref5", name: "Name2", height: 1000, category: .MUNRO, extraItem: 5)
        ]
        
        // When creating Query and Executing
        let sut = try MunroQueryBuilder(for: listMunro)
            .sortByName(.ASC)
            .build()
        
        // Then return MunroQuery
        XCTAssertEqual(sut.execute(),
                       [
                        ItemMock(gridReference: "ref4", name: "Name1", height: 1000, category: .TOP, extraItem: 4),
                        ItemMock(gridReference: "ref5", name: "Name2", height: 1000, category: .MUNRO, extraItem: 5),
                        ItemMock(gridReference: "ref3", name: "Name3", height: 1000, category: .MUNRO, extraItem: 3),
                        ItemMock(gridReference: "ref2", name: "Name4", height: 1000, category: .TOP, extraItem: 2),
                        ItemMock(gridReference: "ref1", name: "Name5", height: 1000, category: .MUNRO, extraItem: 1)
                       ]
        )
    }
    
    func test_createSortByNameDES_BuildAndExecute_ShouldReturnListSortedByNameDES() throws {
        // Given list
        let listMunro: [ItemMock] = [
            ItemMock(gridReference: "ref1", name: "Name5", height: 1000, category: .MUNRO, extraItem: 1),
            ItemMock(gridReference: "ref2", name: "Name4", height: 1000, category: .TOP, extraItem: 2),
            ItemMock(gridReference: "ref3", name: "Name3", height: 1000, category: .MUNRO, extraItem: 3),
            ItemMock(gridReference: "ref4", name: "Name1", height: 1000, category: .TOP, extraItem: 4),
            ItemMock(gridReference: "ref5", name: "Name2", height: 1000, category: .MUNRO, extraItem: 5)
        ]
        
        // When creating Query and Executing
        let sut = try MunroQueryBuilder(for: listMunro)
            .sortByName(.DES)
            .build()
        
        // Then return MunroQuery
        XCTAssertEqual(sut.execute(),
                       [
                        ItemMock(gridReference: "ref1", name: "Name5", height: 1000, category: .MUNRO, extraItem: 1),
                        ItemMock(gridReference: "ref2", name: "Name4", height: 1000, category: .TOP, extraItem: 2),
                        ItemMock(gridReference: "ref3", name: "Name3", height: 1000, category: .MUNRO, extraItem: 3),
                        ItemMock(gridReference: "ref5", name: "Name2", height: 1000, category: .MUNRO, extraItem: 5),
                        ItemMock(gridReference: "ref4", name: "Name1", height: 1000, category: .TOP, extraItem: 4)
                       ]
        )
    }
    
    func test_createSortByNameDuplicate_BuildAndExecute_ShouldThrow() throws {
        // Given list
        let listMunro = createList()
        
        // When creating Builder with sortingByName
        let sut = try MunroQueryBuilder(for: listMunro)
            .sortByName(.ASC)
            
        // Then Throw Error buidling with
        XCTAssertThrowsError(
            try sut
                .sortByName(.DES)
        )
    }
    
    
    // MARK:- Filtering by hill category
    
    func test_createFilteringCategoryMUNRO_BuildAndExecute_ShouldReturnListContainingCategoryMUNRO() throws {
        // Given list
        let listMunro: [ItemMock] = [
            ItemMock(gridReference: "ref1", name: "Name", height: 1000, category: .MUNRO, extraItem: 1),
            ItemMock(gridReference: "ref2", name: "Name", height: 1000, category: .TOP, extraItem: 2),
            ItemMock(gridReference: "ref3", name: "Name", height: 1000, category: .MUNRO, extraItem: 3),
            ItemMock(gridReference: "ref4", name: "Name", height: 1000, category: .TOP, extraItem: 4),
            ItemMock(gridReference: "ref5", name: "Name", height: 1000, category: .MUNRO, extraItem: 5)
        ]
        
        // When creating Query and Executing
        let sut = try MunroQueryBuilder(for: listMunro)
            .filterBy(.MUNRO)
            .build()
        
        // Then return MunroQuery
        XCTAssertEqual(sut.execute(),
                       [
                        ItemMock(gridReference: "ref1", name: "Name", height: 1000, category: .MUNRO, extraItem: 1),
                        ItemMock(gridReference: "ref3", name: "Name", height: 1000, category: .MUNRO, extraItem: 3),
                        ItemMock(gridReference: "ref5", name: "Name", height: 1000, category: .MUNRO, extraItem: 5)
                       ]
        )
    }
    
    func test_createFilteringCategoryTOP_BuildAndExecute_ShouldReturnListContainingCategoryTOP() throws {
        // Given list
        let listMunro: [ItemMock] = [
            ItemMock(gridReference: "ref1", name: "Name", height: 1000, category: .MUNRO, extraItem: 1),
            ItemMock(gridReference: "ref2", name: "Name", height: 1000, category: .TOP, extraItem: 2),
            ItemMock(gridReference: "ref3", name: "Name", height: 1000, category: .MUNRO, extraItem: 3),
            ItemMock(gridReference: "ref4", name: "Name", height: 1000, category: .TOP, extraItem: 4),
            ItemMock(gridReference: "ref5", name: "Name", height: 1000, category: .MUNRO, extraItem: 5)
        ]
        
        // When creating Query and Executing
        let sut = try MunroQueryBuilder(for: listMunro)
            .filterBy(.TOP)
            .build()
        
        // Then return MunroQuery
        XCTAssertEqual(sut.execute(),
                       [
                        ItemMock(gridReference: "ref2", name: "Name", height: 1000, category: .TOP, extraItem: 2),
                        ItemMock(gridReference: "ref4", name: "Name", height: 1000, category: .TOP, extraItem: 4)
                       ]
        )
    }
    
    func test_createFilteringCategoryDuplicate_BuildAndExecute_ShouldThrow() throws {
        // Given list
        let listMunro = createList()
        
        // When creating Builder with filterBy
        let sut = try MunroQueryBuilder(for: listMunro)
            .filterBy(.MUNRO)
            
        // Then Throw Error buidling with
        XCTAssertThrowsError(
            try sut
                .filterBy(.TOP)
        )
    }
    
    // MARK:- Limit results to Min Height
    
    func test_createFilterResultsMinHeight_BuildAndExecute_ShouldReturnListWithHeightSuperiorThatValue() throws {
        // Given list
        let listMunro: [ItemMock] = [
            ItemMock(gridReference: "ref1", name: "Name", height: 100, category: .MUNRO, extraItem: 1),
            ItemMock(gridReference: "ref2", name: "Name", height: 200, category: .TOP, extraItem: 2),
            ItemMock(gridReference: "ref3", name: "Name", height: 300, category: .MUNRO, extraItem: 3),
            ItemMock(gridReference: "ref4", name: "Name", height: 400, category: .TOP, extraItem: 4),
            ItemMock(gridReference: "ref5", name: "Name", height: 500, category: .MUNRO, extraItem: 5)
        ]
        
        // When creating Query and Executing
        let sut = try MunroQueryBuilder(for: listMunro)
            .minHeight(of: 300)
            .build()
        
        // Then return MunroQuery
        XCTAssertEqual(sut.execute(),
                       [
                        ItemMock(gridReference: "ref3", name: "Name", height: 300, category: .MUNRO, extraItem: 3),
                        ItemMock(gridReference: "ref4", name: "Name", height: 400, category: .TOP, extraItem: 4),
                        ItemMock(gridReference: "ref5", name: "Name", height: 500, category: .MUNRO, extraItem: 5)
                       ]
        )
    }
    
    func test_createFilterResultsMinHeightDuplicate_BuildAndExecute_ShouldThrow() throws {
        // Given list
        let listMunro = createList()
        
        // When creating Builder with minHeight
        let sut = try MunroQueryBuilder(for: listMunro)
            .minHeight(of: 100)
            
        // Then Throw Error buidling with
        XCTAssertThrowsError(
            try sut
                .minHeight(of: 300)
        )
    }
    
    
    // MARK:- Limit results to Max Height
    
    func test_createFilterResultsMaxHeight_BuildAndExecute_ShouldReturnListWithHeightInferiorThatValue() throws {
        // Given list
        let listMunro: [ItemMock] = [
            ItemMock(gridReference: "ref1", name: "Name", height: 100, category: .MUNRO, extraItem: 1),
            ItemMock(gridReference: "ref2", name: "Name", height: 200, category: .TOP, extraItem: 2),
            ItemMock(gridReference: "ref3", name: "Name", height: 300, category: .MUNRO, extraItem: 3),
            ItemMock(gridReference: "ref4", name: "Name", height: 400, category: .TOP, extraItem: 4),
            ItemMock(gridReference: "ref5", name: "Name", height: 500, category: .MUNRO, extraItem: 5)
        ]
        
        // When creating Query and Executing
        let sut = try MunroQueryBuilder(for: listMunro)
            .maxHeight(of: 200)
            .build()
        
        // Then return MunroQuery
        XCTAssertEqual(sut.execute(),
                       [
                        ItemMock(gridReference: "ref1", name: "Name", height: 100, category: .MUNRO, extraItem: 1),
                        ItemMock(gridReference: "ref2", name: "Name", height: 200, category: .TOP, extraItem: 2)
                       ]
        )
    }
    
    func test_createFilterResultsMaxHeightDuplicate_BuildAndExecute_ShouldThrow() throws {
        // Given list
        let listMunro = createList()
        
        // When creating Builder with maxHeight
        let sut = try MunroQueryBuilder(for: listMunro)
            .maxHeight(of: 100)
            
        // Then Throw Error buidling with
        XCTAssertThrowsError(
            try sut
                .maxHeight(of: 300)
        )
    }
    
}
extension MunroQueryTests{
    // MARK:- Mock Util
    struct ItemMock: MunroItemType {
        var gridReference: String
        var name: String
        var height: Double
        var category: MunroCategory?
        
        var extraItem: Int
    }
    
    private func createList() -> [ItemMock]{
        return [
            ItemMock(gridReference: "ref1", name: "Name", height: 1005, category: .MUNRO, extraItem: 1),
            ItemMock(gridReference: "ref2", name: "Name", height: 1004, category: nil, extraItem: 2),
            ItemMock(gridReference: "ref3", name: "Name", height: 1003, category: .MUNRO, extraItem: 3),
            ItemMock(gridReference: "ref4", name: "Name", height: 1002, category: nil, extraItem: 4),
            ItemMock(gridReference: "ref5", name: "Name", height: 1001, category: .MUNRO, extraItem: 5)
        ]
    }
    
    // MARK:- Aux
    static var allTests = [
        ("EmptyList", test_createEmptyListQuery_Build_Shouldthrow),
        ("emptyQuery", test_createEmptyQuery_BuildAndExecute_ShouldReturnListWithoutNoneItem),
        
        ("sorByHeightASC", test_createSortByHeightASC_BuildAndExecute_ShouldReturnListSortedByHeightASC),
        ("sorByHeightDES", test_createSortByHeightDESC_BuildAndExecute_ShouldReturnListSortedByHeightDESC),
        ("sorByHeightDuplicate", test_createSortByHeightDuplicate_BuildAndExecute_ShouldThrow),
        
        ("sorByNameASC", test_createSortByNameASC_BuildAndExecute_ShouldReturnListSortedByNameASC),
        ("sorByNameDES", test_createSortByNameDES_BuildAndExecute_ShouldReturnListSortedByNameDES),
        ("sorByNameDuplicate", test_createSortByNameDuplicate_BuildAndExecute_ShouldThrow),
        
        ("filterByCategoryMunro", test_createFilteringCategoryMUNRO_BuildAndExecute_ShouldReturnListContainingCategoryMUNRO),
        ("filterByCategoryTop", test_createFilteringCategoryTOP_BuildAndExecute_ShouldReturnListContainingCategoryTOP),
        ("filterByCategoryDuplicate", test_createFilteringCategoryDuplicate_BuildAndExecute_ShouldThrow)
    ]
}
