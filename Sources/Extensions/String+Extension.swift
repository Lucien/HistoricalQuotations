import Foundation

extension String {
    func substringInfo(startRange: Range<String.Index>,
                       offset: String.IndexDistance) -> (string: String, range: Range<String.Index>) {
        let substringIndexStart = startRange.upperBound
        let substringIndexEnd = index(substringIndexStart, offsetBy: offset)
        let substringRange = substringIndexStart..<substringIndexEnd
        return (String(self[substringRange]).trimmingCharacters(in: .whitespaces), substringRange)
    }
}
