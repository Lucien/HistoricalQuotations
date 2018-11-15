import Foundation

extension HistoricalQuotations {

    public struct Trailer: HeaderProtocol {
        public let registerType: RegisterType
        public let filename: String
        public let sourceCode: String
        public let fileCreationDate: Date
        public let registerCount: Int
    }
}

extension HistoricalQuotations.Trailer: Codable {

    enum CodingKeys: String, CodingKey {
        case registerType
        case filename
        case sourceCode
        case fileCreationDate
        case registerCount
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.registerType = try container.decode(HistoricalQuotations.RegisterType.self, forKey: .registerType)
        self.filename = try container.decode(String.self, forKey: .filename)
        self.sourceCode = try container.decode(String.self, forKey: .sourceCode)
        self.fileCreationDate = try container.decode(Date.self, forKey: .fileCreationDate)
        self.registerCount = try container.decode(Int.self, forKey: .registerCount)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: HistoricalQuotations.Trailer.CodingKeys.self)
        try container.encode(self.registerType, forKey: .registerType)
        try container.encode(self.filename, forKey: .filename)
        try container.encode(self.sourceCode, forKey: .sourceCode)
        try container.encode(self.fileCreationDate, forKey: .fileCreationDate)
        try container.encode(self.registerCount, forKey: .registerCount)
    }
}
