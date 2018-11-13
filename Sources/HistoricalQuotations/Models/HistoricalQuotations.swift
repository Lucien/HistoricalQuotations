import Foundation

public protocol HeaderProtocol {
    var registerType: HistoricalQuotations.RegisterType { get }
    var filename: String { get }
    var sourceCode: String { get }
    var fileCreationDate: Date { get }
}

public struct HistoricalQuotations {

    public enum RegisterType: String {
        case header = "00"
        case dailyPaperQuotation = "01"
        case trailer = "99"
    }

    public struct Header: HeaderProtocol {
        public let registerType: RegisterType
        public let filename: String
        public let sourceCode: String
        public let fileCreationDate: Date
    }

    public struct Trailer: HeaderProtocol {
        public let registerType: RegisterType
        public let filename: String
        public let sourceCode: String
        public let fileCreationDate: Date
        public let registerCount: Int
    }

    public struct PaperQuotation {

        public enum MarketType: String {
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

    public let header: Header
    public let paperQuotations: [PaperQuotation]
    public let trailer: Trailer
}

