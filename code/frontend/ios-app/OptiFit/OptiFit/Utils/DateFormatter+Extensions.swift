import Foundation

extension DateFormatter {
    static let optiFitDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}

extension Date {
    func formattedDate() -> String {
        return DateFormatter.optiFitDateFormatter.string(from: self)
    }
    func mediumFormatted() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
}
