import Foundation

public protocol HeaderProtocol {
    var registerType: HistoricalQuotations.RegisterType { get }
    var filename: String { get }
    var sourceCode: String { get }
    var fileCreationDate: Date { get }
}

public struct HistoricalQuotations {

    public enum RegisterType: String, Codable {
        case header = "00"
        case dailyPaperQuotation = "01"
        case trailer = "99"
    }

    public let header: Header
    public let paperQuotations: [PaperQuotation]
    public let trailer: Trailer
}

extension HistoricalQuotations: Codable {

    enum CodingKeys: String, CodingKey {
        case header
        case paperQuotations
        case trailer
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.header = try container.decode(Header.self, forKey: .header)
        self.paperQuotations = try container.decode([PaperQuotation].self, forKey: .paperQuotations)
        self.trailer = try container.decode(Trailer.self, forKey: .trailer)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.header, forKey: .header)
        try container.encode(self.paperQuotations, forKey: .paperQuotations)
        try container.encode(self.trailer, forKey: .trailer)
    }
}
