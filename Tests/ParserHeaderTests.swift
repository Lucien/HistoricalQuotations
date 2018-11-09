import XCTest
@testable import HistoricalQuotations

class ParserHeaderTests: XCTestCase {

    private let headerLine = "00COTAHIST.2018BOVESPA 20181106"

    private lazy var header: HistoricalQuotations.Header = {
        try! Parser().parseHeader(line: headerLine)
    }()

    func testHeaderRegisterType() {
        XCTAssertEqual(header.registerType, .header)
    }

    func testHeaderFilename() {
        XCTAssertEqual(header.filename, "COTAHIST.2018")
    }

    func testHeaderSourceCode() {
        XCTAssertEqual(header.sourceCode, "BOVESPA ")
    }

    func testHeaderFileCreationDate() {
        let calendar = Calendar(identifier: .gregorian)
        let dateComps = DateComponents(calendar: calendar, year: 2018, month: 11, day: 6)
        XCTAssertEqual(header.fileCreationDate, calendar.date(from: dateComps))
    }
}
