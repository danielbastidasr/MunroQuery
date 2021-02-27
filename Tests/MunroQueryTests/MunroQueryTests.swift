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
    
    // MARK:- Aux
    static var allTests = [
        ("EmptyList", test_createEmptyListQuery_Build_Shouldthrow),
        ("emptyQuery", test_createEmptyQuery_BuildAndExecute_ShouldReturnListWithoutNoneItem),
    ]
}
