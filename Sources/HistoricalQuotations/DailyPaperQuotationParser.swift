import Foundation

extension Parser {

    func parseDailyPaperQuotation(line: String) throws -> HistoricalQuotations.PaperQuotation {

        // TYPE OF REGISTER
        let startRange = Range<String.Index>(uncheckedBounds: (lower: line.startIndex, upper: line.startIndex))
        let registerTypeSubstringInfo = line.substringInfo(startRange: startRange, offset: 2)
        guard let registerType = HistoricalQuotations.RegisterType(rawValue: registerTypeSubstringInfo.string) else {
            throw ParserError.paperQuotation("TYPE OF REGISTER")
        }

        // DATE OF EXCHANGE
        let dateOfExchangeSubstringInfo = line.substringInfo(startRange: registerTypeSubstringInfo.range, offset: 8)
        guard let exchangeDate = dateFormatter.date(from: dateOfExchangeSubstringInfo.string) else {
            throw ParserError.paperQuotation("DATE OF EXCHANGE")
        }

        // BDI CODE
        let bdiCodeSubstringInfo = line.substringInfo(startRange: dateOfExchangeSubstringInfo.range, offset: 2)
        let bdiCode = bdiCodeSubstringInfo.string

        // PAPER NEGOTIATION CODE
        let paperNegotiationCodeSubstringInfo = line.substringInfo(startRange: bdiCodeSubstringInfo.range, offset: 12)
        let paperNegotiationCode = paperNegotiationCodeSubstringInfo.string

        // MARKET TYPE
        let marketTypeSubstringInfo = line.substringInfo(startRange: paperNegotiationCodeSubstringInfo.range, offset: 3)
        let marketTypeString = marketTypeSubstringInfo.string
        guard let marketType = HistoricalQuotations.PaperQuotation.MarketType(rawValue: marketTypeString) else {
            throw ParserError.paperQuotation("MARKET TYPE")
        }

        // NOMRES – ABBREVIATED NAME OF THE COMPANY THAT ISSUED THE PAPER
        let abbreviatedNameSubstringInfo = line.substringInfo(startRange: marketTypeSubstringInfo.range, offset: 12)
        let abbreviatedName = abbreviatedNameSubstringInfo.string

        // ESPECI – PAPER SPECIFICATION
        let paperSpecificationSubstringInfo = line.substringInfo(startRange: abbreviatedNameSubstringInfo.range,
                                                                 offset: 10)
        let paperSpecification = paperSpecificationSubstringInfo.string

        // PRAZOT – FORWARD MARKET TERM IN DAYS
        let forwardMarketTermDaysSubstringInfo = line.substringInfo(startRange: paperSpecificationSubstringInfo.range,
                                                                    offset: 3)
        let forwardMarketTermDays = forwardMarketTermDaysSubstringInfo.string

        // MODREF – REFERENCE CURRENCY
        let referenceCurrencySubstringInfo = line.substringInfo(startRange: forwardMarketTermDaysSubstringInfo.range,
                                                                offset: 4)
        let referenceCurrency = referenceCurrencySubstringInfo.string

        let currencySize = 13

        // PREABE – MARKET PAPER OPENING FLOOR PRICE
        let preabeSubstringInfo = line.substringInfo(startRange: referenceCurrencySubstringInfo.range,
                                                     offset: currencySize)
        guard let preabe = UInt64(preabeSubstringInfo.string) else {
            throw ParserError.paperQuotation("PREABE – MARKET PAPER OPENING FLOOR PRICE")
        }

        // PREMAX – MARKET PAPER HIGHEST FLOOR PRICE
        let premaxSubstringInfo = line.substringInfo(startRange: preabeSubstringInfo.range, offset: currencySize)
        guard let premax = UInt64(premaxSubstringInfo.string) else {
            throw ParserError.paperQuotation("PREMAX – MARKET PAPER HIGHEST FLOOR PRICE")
        }

        // PREMIN – MARKET PAPER LOWEST FLOOR PRICE
        let preminSubstringInfo = line.substringInfo(startRange: premaxSubstringInfo.range, offset: currencySize)
        guard let premin = UInt64(preminSubstringInfo.string) else {
            throw ParserError.paperQuotation("PREMIN – MARKET PAPER LOWEST FLOOR PRICE")
        }

        // PREMED – MARKET PAPER AVERAGE FLOOR PRICE
        let premedSubstringInfo = line.substringInfo(startRange: preminSubstringInfo.range, offset: currencySize)
        guard let premed = UInt64(premedSubstringInfo.string) else {
            throw ParserError.paperQuotation("PREMED – MARKET PAPER AVERAGE FLOOR PRICE")
        }

        // PREULT – MARKET PAPER LAST NEGOTIATED PRICE
        let preultSubstringInfo = line.substringInfo(startRange: premedSubstringInfo.range, offset: currencySize)
        guard let preult = UInt64(preultSubstringInfo.string) else {
            throw ParserError.paperQuotation("PREULT – MARKET PAPER LAST NEGOTIATED PRICE")
        }

        // PREOFC – MARKET PAPER BEST PURCHASE OFFER PRICE
        let preofcSubstringInfo = line.substringInfo(startRange: preultSubstringInfo.range, offset: currencySize)
        guard let preofc = UInt64(preofcSubstringInfo.string) else {
            throw ParserError.paperQuotation("PREOFC – MARKET PAPER BEST PURCHASE OFFER PRICE")
        }

        // PREOFV – MARKET PAPER BEST SALES OFFER PRICE
        let preofvSubstringInfo = line.substringInfo(startRange: preofcSubstringInfo.range, offset: currencySize)
        guard let preofv = UInt64(preofvSubstringInfo.string) else {
            throw ParserError.paperQuotation("PREOFV – MARKET PAPER BEST SALES OFFER PRICE")
        }

        // TOTNEG - NEG. – NUMBER OF TRADES CONDUCTED WITH THE MARKET PAPER
        let totnegSubstrinngInfo = line.substringInfo(startRange: preofvSubstringInfo.range, offset: 5)
        guard let totneg = UInt(totnegSubstrinngInfo.string) else {
            throw ParserError.paperQuotation("TOTNEG - NEG. – NUMBER OF TRADES CONDUCTED WITH THE MARKET PAPER")
        }

        // QUATOT – TOTAL QUANTITY OF TITLES TRADED WITH THIS MARKET PAPER
        let quatotSubstrinngInfo = line.substringInfo(startRange: totnegSubstrinngInfo.range, offset: 18)
        guard let quatot = UInt(quatotSubstrinngInfo.string) else {
            throw ParserError.paperQuotation("QUATOT – TOTAL QUANTITY OF TITLES TRADED WITH THIS MARKET PAPER")
        }

        // VOLTOT – TOTAL VOLUME OF TITLES NEGOTIATED WITH THIS MARKET PAPER
        let voltotSubstrinngInfo = line.substringInfo(startRange: quatotSubstrinngInfo.range, offset: 18)
        guard let voltot = UInt(voltotSubstrinngInfo.string) else {
            throw ParserError.paperQuotation("VOLTOT – TOTAL VOLUME OF TITLES NEGOTIATED WITH THIS MARKET PAPER")
        }

        // PREEXE – STRIKE PRICE FOR THE OPTIONS MARKET OR CONTRACT AMOUNT FOR THE SECONDARY FORWARD MARKET
        let preexeSubstringInfo = line.substringInfo(startRange: voltotSubstrinngInfo.range, offset: currencySize)
        guard let preexe = UInt64(preexeSubstringInfo.string) else {
            throw ParserError.paperQuotation("PREEXE – STRIKE PRICE FOR THE OPTIONS MARKET OR CONTRACT AMOUNT FOR THE SECONDARY FORWARD MARKET")
        }

        // INDOPC – STRIKE PRICE OR CONTRACT AMOUNT FOR OPTIONS OR SECONDARY FORWARD MARKETS CORRECTION INDICATOR
        let indopcSubstringInfo = line.substringInfo(startRange: preexeSubstringInfo.range, offset: 1)
        guard let indopc = Int(indopcSubstringInfo.string) else {
            throw ParserError.paperQuotation("INDOPC – STRIKE PRICE OR CONTRACT AMOUNT FOR OPTIONS OR SECONDARY FORWARD MARKETS CORRECTION INDICATOR")
        }

        // DATVEN – MATURITY DATE FOR OPTIONS OR SECONDARY FORWARD MARKETS
        let datvenSubstringInfo = line.substringInfo(startRange: indopcSubstringInfo.range, offset: 8)
        guard let datven = dateFormatter.date(from: datvenSubstringInfo.string) else {
            throw ParserError.paperQuotation("DATVEN – MATURITY DATE FOR OPTIONS OR SECONDARY FORWARD MARKETS")
        }

        // FATCOT – PAPER QUOTATION FACTOR
        let fatcotSubstringInfo = line.substringInfo(startRange: datvenSubstringInfo.range, offset: 7)
        guard let fatcot = Int(fatcotSubstringInfo.string) else {
            throw ParserError.paperQuotation("FATCOT – PAPER QUOTATION FACTOR")
        }

        // PTOEXE – STRIKE PRICE IN POINTS FOR OPTIONS REFERENCED IN US DOLLARS OR CONTRACT AMOUNT IN POINTS FOR SECONDARY FORWARD
        let ptoexeSubstringInfo = line.substringInfo(startRange: fatcotSubstringInfo.range, offset: currencySize)
        guard let ptoexe = UInt(ptoexeSubstringInfo.string) else {
            throw ParserError.paperQuotation("PTOEXE")
        }

        // CODISI – PAPER CODE IN THE ISIN SYSTEM OR PAPER INTERNAL CODE
        let paperCodeISISystemSubstringInfo = line.substringInfo(startRange: ptoexeSubstringInfo.range, offset: 12)
        let paperCodeISISystem = paperCodeISISystemSubstringInfo.string

        // DISMES – PAPER DISTRIBUTION NUMBER
        let paperDistributionNumberSubstringInfo = line.substringInfo(startRange: paperCodeISISystemSubstringInfo.range, offset: 3)
        let paperDistributionNumber = paperDistributionNumberSubstringInfo.string

        return try! HistoricalQuotations.PaperQuotation(registerType: registerType,
                                                        exchangeDate: exchangeDate,
                                                        bdiCode: bdiCode,
                                                        paperNegotiationCode: paperNegotiationCode,
                                                        marketType: marketType,
                                                        abbreviattedName: abbreviatedName,
                                                        paperSpecification: paperSpecification,
                                                        forwardMarketTermDays: forwardMarketTermDays,
                                                        referenceCurrency: referenceCurrency,
                                                        marketPaperOpeningFloorPrice: preabe,
                                                        marketPaperHightestFloorPrice: premax,
                                                        marketPaperLowestFloorPrice: premin,
                                                        marketPaperAverageFloorPrice: premed,
                                                        marketPaperLastNegotiatedPrice: preult,
                                                        marketPaperBestPurchaseOfferPrice: preofc,
                                                        marketPaperBestSalesOfferPrice: preofv,
                                                        numberOfTradesConductedWithMarketPaper: totneg,
                                                        totalQuantityOfTitlesTraded: quatot,
                                                        totalVolumeOfTitlesNegotiated: voltot,
                                                        strikePriceForTheOptionsMarket: preexe,
                                                        strikePriceOrContractAmountForOptions: indopc,
                                                        maturityDateForOptions: datven,
                                                        paperQuotationFactor: fatcot,
                                                        ptoexe: ptoexe,
                                                        paperCodeISISystem: paperCodeISISystem,
                                                        paperDistributionNumber: paperDistributionNumber)
    }
}
