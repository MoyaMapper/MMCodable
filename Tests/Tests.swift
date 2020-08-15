import XCTest
import MMCodable
import SwiftyJSON

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testModel() {
        let dict: [String : Any] = [
            "goodJob" : "1",
            "aModels" : [
                [
                    "name":1
                ],
                [
                    "aname":2
                ],
                [
                    "aname":3
                ],
            ],
            "cModels" : [
                [
                    "value":4
                ],
                [
                    "cvalue":5
                ]
            ],
        ]
        guard let jsonStr = JSON(dict).rawString() else {
            return
        }
        guard let jsonData = jsonStr.data(using: .utf8) else {
            return
        }
        let decoder = MMJSONDecoder()
        do {
            let model = try decoder.decode(BModel.self, from: jsonData)
            print("model -- \(model)")
            XCTAssertEqual(model.d3, 4)
            XCTAssertEqual(model.goodJob, "1")
            XCTAssertEqual(model.aModels.count, 3)
            XCTAssertEqual(model.cModels.count, 2)
            XCTAssertEqual(model.aModels[0].name, "")
            XCTAssertEqual(model.aModels[1].name, "2")
            XCTAssertEqual(model.aModels[2].name, "3")
            XCTAssertEqual(model.cModels[0].value, 4)
            XCTAssertEqual(model.cModels[1].value, 2)
        } catch {
            XCTAssertNil(error)
        }
    }
}
