import XCTest
@testable import HistoricalQuotations

class DailyPaperQuotationParserTests: XCTestCase {

    private let paperLine = "012018011702IBOV11      010IBOVESPA    IBO          R$  000000808720000000080872000000008087200000000808720000000080872000000000000000000000000000000069000000000000027530000000222640616000000000000000009999123100000010000000000000BRIBOVINDM18005"

    private lazy var paperQuotation: HistoricalQuotations.PaperQuotation = {
        try! Parser().parseDailyPaperQuotation(line: paperLine)
    }()

    func testRegisterType() {
        XCTAssertEqual(paperQuotation.registerType, .dailyPaperQuotation)
    }

    func testExchangeDate() {
        XCTAssertEqual(paperQuotation.exchangeDate, Date(timeIntervalSince1970: 1516154400))
    }

    func testBDICode() {
        XCTAssertEqual(paperQuotation.bdiCode, "02")
    }

    func testPaperNegotiationCode() {
        XCTAssertEqual(paperQuotation.paperNegotiationCode, "IBOV11")
    }

    func testMarketType() {
        XCTAssertEqual(paperQuotation.marketType, .cash)
    }

    func testAbbreviatedNameOfTheCompanyThatIssuedThePaper() {
        XCTAssertEqual(paperQuotation.abbreviattedName, "IBOVESPA")
    }

    func testPaperSpecification() {
        XCTAssertEqual(paperQuotation.paperSpecification, "IBO")
    }

    func testForwardMarketTermDays() {
        XCTAssertEqual(paperQuotation.forwardMarketTermDays, "")
    }

    func testReferenceCurrency() {
        XCTAssertEqual(paperQuotation.referenceCurrency, "BRL")
    }

    func testMarketPaperOpeningFloorPrice() {
        XCTAssertEqual(paperQuotation.marketPaperOpeningFloorPrice, NSDecimalNumber(string: "80872.00"))
    }

    func testMarketPaperHightestFloorPrice() {
        XCTAssertEqual(paperQuotation.marketPaperHightestFloorPrice, NSDecimalNumber(string: "80872.00"))
    }

    func testMarketPaperLowestFloorPrice() {
        XCTAssertEqual(paperQuotation.marketPaperLowestFloorPrice, NSDecimalNumber(string: "80872.00"))
    }

    func testMarketPaperAverageFloorPrice() {
        XCTAssertEqual(paperQuotation.marketPaperAverageFloorPrice, NSDecimalNumber(string: "80872.00"))
    }

    func testMarketPaperLastNegotiatedPrice() {
        XCTAssertEqual(paperQuotation.marketPaperLastNegotiatedPrice, NSDecimalNumber(string: "80872.00"))
    }

    func testMarketPaperBestPurchaseOfferPrice() {
        XCTAssertEqual(paperQuotation.marketPaperBestPurchaseOfferPrice, NSDecimalNumber(string: "0.00"))
    }

    func testMarketPaperBestSalesOfferPrice() {
        XCTAssertEqual(paperQuotation.marketPaperBestSalesOfferPrice, NSDecimalNumber(string: "0.00"))
    }

    func testNumberOfTradesConductedWithMarketPaper() {
        XCTAssertEqual(paperQuotation.numberOfTradesConductedWithMarketPaper, 69)
    }

    func testTotalQuantityOfTitlesTraded() {
        XCTAssertEqual(paperQuotation.totalQuantityOfTitlesTraded, 27530)
    }

    func testTotalVolumeOfTitlesNegotiated() {
        XCTAssertEqual(paperQuotation.totalVolumeOfTitlesNegotiated, 222640616000)
    }

    func testStrikePriceForTheOptionsMarket() {
        XCTAssertEqual(paperQuotation.strikePriceForTheOptionsMarket, 0)
    }

    func testStrikePriceOrContractAmountForOptions() {
        XCTAssertEqual(paperQuotation.strikePriceOrContractAmountForOptions, 0)
    }

    func testMaturityDateForOptions() {
        XCTAssertEqual(paperQuotation.maturityDateForOptions, Date(timeIntervalSince1970: 253402221600))
    }

    func testPaperQuotationFactor() {
        XCTAssertEqual(paperQuotation.paperQuotationFactor, 1)
    }

    func testPTOEXE() {
        XCTAssertEqual(paperQuotation.ptoexe, 0)
    }

    func testPaperCodeISISystem() {
        XCTAssertEqual(paperQuotation.paperCodeISISystem, "BRIBOVINDM18")
    }

    func testPaperDistributionNumber() {
        XCTAssertEqual(paperQuotation.paperDistributionNumber, "005")
    }
}
