//
//  TimeEntry.swift
//  Toggler
//
//  Created by Shohei Fukui on 2021/02/04.
//  
//
import Foundation

struct TimeEntry: Decodable {
    let id: Int
    let wid: Int
    let pid: Int?
    let start:Date?
    let stop:String?
    let duration: Int
    let description: String
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

    init(from decoder: Decoder) throws {
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
