import Foundation

extension HistoricalQuotations {

    public struct Header: HeaderProtocol {
        public let registerType: RegisterType
        public let filename: String
        public let sourceCode: String
        public let fileCreationDate: Date
    }
}

extension HistoricalQuotations.Header: Codable {

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: HistoricalQuotations.Trailer.CodingKeys.self)
        self.registerType = try container.decode(HistoricalQuotations.RegisterType.self, forKey: .registerType)
        self.filename = try container.decode(String.self, forKey: .filename)
        self.sourceCode = try container.decode(String.self, forKey: .sourceCode)
        self.fileCreationDate = try container.decode(Date.self, forKey: .fileCreationDate)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: HistoricalQuotations.Trailer.CodingKeys.self)
        try container.encode(self.registerType, forKey: .registerType)
        try container.encode(self.filename, forKey: .filename)
        try container.encode(self.sourceCode, forKey: .sourceCode)
        try container.encode(self.fileCreationDate, forKey: .fileCreationDate)
    }
}
