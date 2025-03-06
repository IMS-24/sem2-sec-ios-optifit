//
//  ISO8601CustomCoder.swift
//  OptiFit
//
//  Created by Markus Stoegerer on 05.03.25.
//


import Foundation

struct ISO8601CustomCoder {
    /// A DateFormatter that matches backend dates like: "2025-03-05T09:29:48.502+00:00"
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        return formatter
    }

    /// Returns a JSONDecoder configured to use our custom ISO8601 date formatter.
    static func makeDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        let formatter = dateFormatter
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            if let date = formatter.date(from: dateString) {
                return date
            }
            throw DecodingError.dataCorruptedError(
                    in: container,
                    debugDescription: "Cannot decode date string \(dateString)"
            )
        }
        return decoder
    }

    /// Returns a JSONEncoder configured to use our custom ISO8601 date formatter.
    static func makeEncoder() -> JSONEncoder {
        let encoder = JSONEncoder()
        let formatter = dateFormatter
        encoder.dateEncodingStrategy = .custom { date, encoder in
            var container = encoder.singleValueContainer()
            let dateString = formatter.string(from: date)
            try container.encode(dateString)
        }
        return encoder
    }
}
