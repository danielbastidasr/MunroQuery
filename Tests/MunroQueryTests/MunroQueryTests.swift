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
    ]
}
