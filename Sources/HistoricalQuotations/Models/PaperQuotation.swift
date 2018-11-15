import Foundation

extension HistoricalQuotations {

    public struct PaperQuotation {

        public enum MarketType: String, Codable {
            case cash = "010"
            case exerciseOfCallOptions = "012"
            case exerciseOfPutOptions = "013"
            case auction = "017"
            case fractionary = "020"
            case term = "030"
            case forwardWithGainRetention = "050"
            case forwardWithContinuousMovement = "060"
            case callOptions = "070"
            case putOptions = "080"
        }

        public let registerType: RegisterType
        public let exchangeDate: Date
        public let bdiCode: String
        public let paperNegotiationCode: String
        public let marketType: MarketType
        public let abbreviattedName: String
        public let paperSpecification: String
        public let forwardMarketTermDays: String
        public let referenceCurrency: String?
        public let marketPaperOpeningFloorPrice: NSDecimalNumber
        public let marketPaperHightestFloorPrice: NSDecimalNumber
        public let marketPaperLowestFloorPrice: NSDecimalNumber
        public let marketPaperAverageFloorPrice: NSDecimalNumber
        public let marketPaperLastNegotiatedPrice: NSDecimalNumber
        public let marketPaperBestPurchaseOfferPrice: NSDecimalNumber
        public let marketPaperBestSalesOfferPrice: NSDecimalNumber
        public let numberOfTradesConductedWithMarketPaper: UInt
        public let totalQuantityOfTitlesTraded: UInt
        public let totalVolumeOfTitlesNegotiated: UInt
        public let strikePriceForTheOptionsMarket: NSDecimalNumber
        public let strikePriceOrContractAmountForOptions: Int
        public let maturityDateForOptions: Date
        public let paperQuotationFactor: Int
        public let ptoexe: UInt
        public let paperCodeISISystem: String
        public let paperDistributionNumber: String

        public init(registerType: RegisterType,
                    exchangeDate: Date,
                    bdiCode: String,
                    paperNegotiationCode: String,
                    marketType: MarketType,
                    abbreviattedName: String,
                    paperSpecification: String,
                    forwardMarketTermDays: String,
                    referenceCurrency: String?,
                    marketPaperOpeningFloorPrice: UInt64,
                    marketPaperHightestFloorPrice: UInt64,
                    marketPaperLowestFloorPrice: UInt64,
                    marketPaperAverageFloorPrice: UInt64,
                    marketPaperLastNegotiatedPrice: UInt64,
                    marketPaperBestPurchaseOfferPrice: UInt64,
                    marketPaperBestSalesOfferPrice: UInt64,
                    numberOfTradesConductedWithMarketPaper: UInt,
                    totalQuantityOfTitlesTraded: UInt,
                    totalVolumeOfTitlesNegotiated: UInt,
                    strikePriceForTheOptionsMarket: UInt64,
                    strikePriceOrContractAmountForOptions: Int,
                    maturityDateForOptions: Date,
                    paperQuotationFactor: Int,
                    ptoexe: UInt,
                    paperCodeISISystem: String,
                    paperDistributionNumber: String) throws {

            self.registerType = registerType
            self.exchangeDate = exchangeDate
            self.bdiCode = bdiCode
            self.paperNegotiationCode = paperNegotiationCode
            self.marketType = marketType
            self.abbreviattedName = abbreviattedName
            self.paperSpecification = paperSpecification
            self.forwardMarketTermDays = forwardMarketTermDays
            self.referenceCurrency = type(of: self).convertToISO4217(from: referenceCurrency)

            let exponent: Int16 = -2
            let isNegative = false
            self.marketPaperOpeningFloorPrice = NSDecimalNumber(mantissa: marketPaperOpeningFloorPrice,
                                                                exponent: exponent,
                                                                isNegative: isNegative)
            self.marketPaperHightestFloorPrice = NSDecimalNumber(mantissa: marketPaperHightestFloorPrice,
                                                                 exponent: exponent,
                                                                 isNegative: isNegative)
            self.marketPaperLowestFloorPrice = NSDecimalNumber(mantissa: marketPaperLowestFloorPrice,
                                                               exponent: exponent,
                                                               isNegative: isNegative)
            self.marketPaperAverageFloorPrice = NSDecimalNumber(mantissa: marketPaperAverageFloorPrice,
                                                                exponent: exponent,
                                                                isNegative: isNegative)
            self.marketPaperLastNegotiatedPrice = NSDecimalNumber(mantissa: marketPaperAverageFloorPrice,
                                                                  exponent: exponent,
                                                                  isNegative: isNegative)
            self.marketPaperBestPurchaseOfferPrice = NSDecimalNumber(mantissa: marketPaperBestPurchaseOfferPrice,
                                                                     exponent: exponent,
                                                                     isNegative: isNegative)
            self.marketPaperBestSalesOfferPrice = NSDecimalNumber(mantissa: marketPaperBestSalesOfferPrice,
                                                                  exponent: exponent,
                                                                  isNegative: isNegative)
            self.numberOfTradesConductedWithMarketPaper = numberOfTradesConductedWithMarketPaper
            self.totalQuantityOfTitlesTraded = totalQuantityOfTitlesTraded
            self.totalVolumeOfTitlesNegotiated = totalVolumeOfTitlesNegotiated
            self.strikePriceForTheOptionsMarket = NSDecimalNumber(mantissa: strikePriceForTheOptionsMarket,
                                                                  exponent: exponent,
                                                                  isNegative: isNegative)
            self.strikePriceOrContractAmountForOptions = strikePriceOrContractAmountForOptions
            self.maturityDateForOptions = maturityDateForOptions
            self.paperQuotationFactor = paperQuotationFactor
            self.ptoexe = ptoexe
            self.paperCodeISISystem = paperCodeISISystem
            self.paperDistributionNumber = paperDistributionNumber
        }

        static func convertToISO4217(from referenceCurrency: String?) -> String? {
            switch referenceCurrency {
            case "R$":
                return "BRL"
            default:
                return nil
            }
        }
    }
}

extension HistoricalQuotations.PaperQuotation: Codable {

    enum CodingKeys: String, CodingKey {
        case registerType
        case exchangeDate
        case bdiCode
        case paperNegotiationCode
        case marketType
        case abbreviattedName
        case paperSpecification
        case forwardMarketTermDays
        case referenceCurrency
        case marketPaperOpeningFloorPrice
        case marketPaperHightestFloorPrice
        case marketPaperLowestFloorPrice
        case marketPaperAverageFloorPrice
        case marketPaperLastNegotiatedPrice
        case marketPaperBestPurchaseOfferPrice
        case marketPaperBestSalesOfferPrice
        case numberOfTradesConductedWithMarketPaper
        case totalQuantityOfTitlesTraded
        case totalVolumeOfTitlesNegotiated
        case strikePriceForTheOptionsMarket
        case strikePriceOrContractAmountForOptions
        case maturityDateForOptions
        case paperQuotationFactor
        case ptoexe
        case paperCodeISISystem
        case paperDistributionNumber
    }

    public init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: HistoricalQuotations.PaperQuotation.CodingKeys.self)
        self.registerType = try container.decode(HistoricalQuotations.RegisterType.self, forKey: .registerType)
        self.exchangeDate = try container.decode(Date.self, forKey: .exchangeDate)
        self.bdiCode = try container.decode(String.self, forKey: .bdiCode)
        self.paperNegotiationCode = try container.decode(String.self, forKey: .paperNegotiationCode)
        self.marketType = try container.decode(MarketType.self, forKey: .marketType)
        self.abbreviattedName = try container.decode(String.self, forKey: .abbreviattedName)
        self.paperSpecification = try container.decode(String.self, forKey: .paperSpecification)
        self.forwardMarketTermDays = try container.decode(String.self, forKey: .forwardMarketTermDays)

        self.referenceCurrency = try container.decode(String.self, forKey: .referenceCurrency)

        let marketPaperOpeningFloorPriceString = try container.decode(String.self, forKey: .marketPaperOpeningFloorPrice)
        self.marketPaperOpeningFloorPrice = NSDecimalNumber(string: marketPaperOpeningFloorPriceString)

        let marketPaperHightestFloorPriceString = try container.decode(String.self, forKey: .marketPaperHightestFloorPrice)
        self.marketPaperHightestFloorPrice = NSDecimalNumber(string: marketPaperHightestFloorPriceString)

        let marketPaperLowestFloorPriceString = try container.decode(String.self, forKey: .marketPaperLowestFloorPrice)
        self.marketPaperLowestFloorPrice = NSDecimalNumber(string: marketPaperLowestFloorPriceString)

        let marketPaperAverageFloorPriceString = try container.decode(String.self, forKey: .marketPaperAverageFloorPrice)
        self.marketPaperAverageFloorPrice = NSDecimalNumber(string: marketPaperAverageFloorPriceString)

        let marketPaperLastNegotiatedPriceString = try container.decode(String.self, forKey: .marketPaperLastNegotiatedPrice)
        self.marketPaperLastNegotiatedPrice = NSDecimalNumber(string: marketPaperLastNegotiatedPriceString)

        let marketPaperBestPurchaseOfferPriceString = try container.decode(String.self, forKey: .marketPaperBestPurchaseOfferPrice)
        self.marketPaperBestPurchaseOfferPrice = NSDecimalNumber(string: marketPaperBestPurchaseOfferPriceString)

        let marketPaperBestSalesOfferPriceString = try container.decode(String.self, forKey: .marketPaperBestSalesOfferPrice)
        self.marketPaperBestSalesOfferPrice = NSDecimalNumber(string: marketPaperBestSalesOfferPriceString)

        self.numberOfTradesConductedWithMarketPaper = try container.decode(UInt.self, forKey: .numberOfTradesConductedWithMarketPaper)
        self.totalQuantityOfTitlesTraded = try container.decode(UInt.self, forKey: .totalQuantityOfTitlesTraded)
        self.totalVolumeOfTitlesNegotiated = try container.decode(UInt.self, forKey: .totalVolumeOfTitlesNegotiated)

        let strikePriceForTheOptionsMarketString = try container.decode(String.self, forKey: .strikePriceForTheOptionsMarket)
        self.strikePriceForTheOptionsMarket = NSDecimalNumber(string: strikePriceForTheOptionsMarketString)

        self.strikePriceOrContractAmountForOptions = try container.decode(Int.self, forKey: .strikePriceOrContractAmountForOptions)

        self.maturityDateForOptions = try container.decode(Date.self, forKey: .maturityDateForOptions)
        self.paperQuotationFactor = try container.decode(Int.self, forKey: .paperQuotationFactor)

        self.ptoexe = try container.decode(UInt.self, forKey: .ptoexe)
        self.paperCodeISISystem = try container.decode(String.self, forKey: .paperCodeISISystem)
        self.paperDistributionNumber = try container.decode(String.self, forKey: .paperDistributionNumber)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(self.registerType, forKey: .registerType)
        try container.encode(self.exchangeDate, forKey: .exchangeDate)
        try container.encode(self.bdiCode, forKey: .bdiCode)
        try container.encode(self.paperNegotiationCode, forKey: .paperNegotiationCode)
        try container.encode(self.marketType, forKey: .marketType)
        try container.encode(self.abbreviattedName, forKey: .abbreviattedName)
        try container.encode(self.paperSpecification, forKey: .paperSpecification)
        try container.encode(self.forwardMarketTermDays, forKey: .forwardMarketTermDays)
        try container.encode(self.referenceCurrency, forKey: .referenceCurrency)
        try container.encode(self.marketPaperOpeningFloorPrice.stringValue, forKey: .marketPaperOpeningFloorPrice)
        try container.encode(self.marketPaperHightestFloorPrice.stringValue, forKey: .marketPaperHightestFloorPrice)
        try container.encode(self.marketPaperLowestFloorPrice.stringValue, forKey: .marketPaperLowestFloorPrice)
        try container.encode(self.marketPaperAverageFloorPrice.stringValue, forKey: .marketPaperAverageFloorPrice)
        try container.encode(self.marketPaperLastNegotiatedPrice.stringValue, forKey: .marketPaperLastNegotiatedPrice)
        try container.encode(self.marketPaperBestPurchaseOfferPrice.stringValue, forKey: .marketPaperBestPurchaseOfferPrice)
        try container.encode(self.marketPaperBestSalesOfferPrice.stringValue, forKey: .marketPaperBestSalesOfferPrice)
        try container.encode(self.numberOfTradesConductedWithMarketPaper, forKey: .numberOfTradesConductedWithMarketPaper)
        try container.encode(self.totalQuantityOfTitlesTraded, forKey: .totalQuantityOfTitlesTraded)
        try container.encode(self.totalVolumeOfTitlesNegotiated, forKey: .totalVolumeOfTitlesNegotiated)
        try container.encode(self.strikePriceForTheOptionsMarket.stringValue, forKey: .strikePriceForTheOptionsMarket)
        try container.encode(self.strikePriceOrContractAmountForOptions, forKey: .strikePriceOrContractAmountForOptions)
        try container.encode(self.maturityDateForOptions, forKey: .maturityDateForOptions)
        try container.encode(self.paperQuotationFactor, forKey: .paperQuotationFactor)
        try container.encode(self.ptoexe, forKey: .ptoexe)
        try container.encode(self.paperCodeISISystem, forKey: .paperCodeISISystem)
        try container.encode(self.paperDistributionNumber, forKey: .paperDistributionNumber)

    }
}
