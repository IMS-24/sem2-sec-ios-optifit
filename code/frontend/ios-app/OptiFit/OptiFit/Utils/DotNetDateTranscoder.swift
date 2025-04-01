import Foundation
import OpenAPIRuntime

public struct DotNetDateTranscoder: DateTranscoder {
    public init() {}

    public func decode(_ value: String) throws -> Date {
        let iso8601Formatter = ISO8601DateFormatter()
        iso8601Formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        // Try ISO8601 format first
        if let date = iso8601Formatter.date(from: value) {
            return date
        }

        // Fallback for .NET DateTimeOffset with offset (e.g., "2025-03-10T12:34:56.1234567+00:00")
        let fallbackFormatter = ISO8601CustomCoder.dateFormatter
        //        DateFormatter()
        //        fallbackFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        //        fallbackFormatter.locale = Locale(identifier: "en_US_POSIX")
        //        fallbackFormatter.timeZone = TimeZone(secondsFromGMT: 0)

        if let fallbackDate = fallbackFormatter.date(from: value) {
            return fallbackDate
        }

        throw DecodingError.dataCorrupted(
            DecodingError.Context(codingPath: [], debugDescription: "Invalid .NET DateTimeOffset format: \(value)")
        )
    }

    public func encode(_ value: Date) throws -> String {
        let iso8601Formatter = ISO8601DateFormatter()
        iso8601Formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return iso8601Formatter.string(from: value)
    }
}
