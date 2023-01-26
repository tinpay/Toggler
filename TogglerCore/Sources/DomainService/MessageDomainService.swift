//
//  Converter.swift
//  Toggler
//
//  Created by Shohei Fukui on 2021/04/18.
//  
//

import Foundation
import Project
import TimeEntry

public class MessageDomainService {
    public static func dateString(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }

    public static func projectName(projects: [Project], pid: Int?) -> String {
        guard let pid = pid else {return ""}

        let project = projects.first(where: {$0.id == pid})?.name ?? "<n>"
        return "(\(project)))"

    }

    public static func makeEntriesString(date: Date, timeEntries: [TimeEntry]) -> String?{
    //        return "(*) "  + dateString(date: date) + "\n" + timeEntries.map { "- \($0.desc)(\($0.durationHourMinuteSecond))\n"}.joined()
        return "(*) "  + dateString(date: date) + "\n" + timeEntries.map { "- \($0.description)"}.joined()

    }
}
