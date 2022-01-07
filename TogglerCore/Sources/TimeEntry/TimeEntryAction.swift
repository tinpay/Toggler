//
//  TimeEntryAction.swift
//  
//
//  Created by Shohei Fukui on 2021/09/26.
//  
//
import TogglerCore

public struct FetchTimeEntriesAction: Action {
    public let timeEntries: [TimeEntry]
    public init(timeEntries: [TimeEntry]) {
        self.timeEntries = timeEntries
    }
}
