//
//  TimeEntry.swift
//  Toggler
//
//  Created by Shohei Fukui on 2021/02/04.
//  
//
import Foundation

public struct TimeEntry: Decodable {
    public let id: Int
    public let wid: Int
    public let pid: Int?
    public let start:Date?
    public let stop:String?
    public let duration: Int
    public let description: String
    enum CodingKeys: String, CodingKey {
        case id
        case wid
        case pid
        case start
        case stop
        case duration
        case description

    }

    var durationHourMinuteSecond: String {
        let hour = duration / 3600
        let minute = (duration % 3600) / 60
        return "\(String(format: "%02d", hour)):\(String(format: "%02d", minute))"
      }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        wid = try values.decode(Int.self, forKey: .wid)
        pid = try? values.decode(Int.self, forKey: .pid)

        let dateFormatter = ISO8601DateFormatter()
        if let startString = try? values.decode(String.self, forKey: .start) {
            start = dateFormatter.date(from: startString)
        } else {
            start = nil
        }

        stop = try? values.decode(String.self, forKey: .stop)
        duration = try values.decode(Int.self, forKey: .duration)
        description = try values.decode(String.self, forKey: .description)

    }

}
