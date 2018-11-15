import Foundation

public enum ParserError: Error {
    case header(String)
    case paperQuotation(String)
    case trailer(String)
}

public class Parser {

    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYYMMdd"
        return dateFormatter
    }()

    public init() {}

    public func historicalQuotationsFromFile(at path: String) throws -> HistoricalQuotations {
        let url = URL(fileURLWithPath: path)

        let content = try! String(contentsOf: url)
        var lines = content.split(whereSeparator: { character -> Bool in
            character == "\n" || character == "\r\n"
        }).map(String.init)

        let header = try parseHeader(line: lines.first)
        let trailer = try parseTrailer(line: lines.last)

        lines = Array(lines.dropFirst())
        lines = Array(lines.dropLast())

        let paperQuotations = lines.concurrentMap { line -> HistoricalQuotations.PaperQuotation in
            try! self.parseDailyPaperQuotation(line: line)
        }

        return HistoricalQuotations(header: header,
                                    paperQuotations: paperQuotations,
                                    trailer: trailer)
    }

    func parseHeader(line: String?) throws -> HistoricalQuotations.Header {

        guard let line = line else {
            throw ParserError.header("no line")
        }

        // TYPE OF REGISTER
        let startRange = Range<String.Index>(uncheckedBounds: (lower: line.startIndex, upper: line.startIndex))
        let registerTypeSubstringInfo = line.substringInfo(startRange: startRange, offset: 2)
        guard let registerType = HistoricalQuotations.RegisterType(rawValue: registerTypeSubstringInfo.string) else {
            throw ParserError.header("TYPE OF REGISTER")
        }

        // FILE NAME
        let filenameSubstringInfo = line.substringInfo(startRange: registerTypeSubstringInfo.range, offset: 13)
        let filename = filenameSubstringInfo.string

        // SOURCE CODE
        let sourceCodeSubstringInfo = line.substringInfo(startRange: filenameSubstringInfo.range, offset: 8)
        let sourceCode = sourceCodeSubstringInfo.string

        // FILE GENERATION DATE
        let fileCreationDateSubstringInfo = line.substringInfo(startRange: sourceCodeSubstringInfo.range, offset: 8)
        guard let fileCreationDate = dateFormatter.date(from: fileCreationDateSubstringInfo.string) else {
            throw ParserError.header("FILE GENERATION DATE")
        }

        return HistoricalQuotations.Header(registerType: registerType,
                                           filename: filename,
                                           sourceCode: sourceCode,
                                           fileCreationDate: fileCreationDate)
    }

    func parseTrailer(line: String?) throws -> HistoricalQuotations.Trailer {

        let header = try parseHeader(line: line)

        guard let line = line else {
            throw ParserError.trailer("no line")
        }

        // TOTAL REGISTERS
        let registerCountIndexStart = line.index(line.startIndex, offsetBy: 31)
        let registerCountIndexEnd = line.index(registerCountIndexStart, offsetBy: 11)
        let registerCountRange = registerCountIndexStart..<registerCountIndexEnd

        let registerCountString = String(line[registerCountRange])

        guard let registerCount = Int(registerCountString) else {
            throw ParserError.header("TOTAL REGISTERS")
        }

        return HistoricalQuotations.Trailer(registerType: header.registerType,
                                            filename: header.filename,
                                            sourceCode: header.sourceCode,
                                            fileCreationDate: header.fileCreationDate,
                                            registerCount: registerCount)
    }
}
