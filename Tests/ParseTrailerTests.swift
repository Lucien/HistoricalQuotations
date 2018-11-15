import XCTest
@testable import HistoricalQuotations

class ParserTrailerTests: XCTestCase {

    private let trailerLine = "99COTAHIST.2018BOVESPA 2018110600000491487"

    private lazy var trailer: HistoricalQuotations.Trailer = {
        try! Parser().parseTrailer(line: trailerLine)
    }()

    func testTrailerRegisterType() {
        XCTAssertEqual(trailer.registerType, .trailer)
    }

    func testTrailerFilename() {
        XCTAssertEqual(trailer.filename, "COTAHIST.2018")
    }

    func testTrailerSourceCode() {
        XCTAssertEqual(trailer.sourceCode, "BOVESPA")
    }

    func testTrailerFileCreationDate() {
        let calendar = Calendar(identifier: .gregorian)
        let dateComps = DateComponents(calendar: calendar, year: 2018, month: 11, day: 6)
        XCTAssertEqual(trailer.fileCreationDate, calendar.date(from: dateComps))
    }

    func testTrailerRegisterCount() {
        XCTAssertEqual(trailer.registerCount, 491487)
    }

    func testEncodeAndDecode() {
        let encoder = JSONEncoder()
        do {
            let trailerData = try encoder.encode(trailer)

            let decoder = JSONDecoder()
            do {
                _ = try decoder.decode(HistoricalQuotations.Trailer.self, from: trailerData)
            } catch {
                XCTFail(error.localizedDescription)
            }
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
}
