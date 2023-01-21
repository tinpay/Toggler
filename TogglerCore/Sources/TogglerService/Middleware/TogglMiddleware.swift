//
//  TogglMiddleware.swift
//  Toggler
//
//  Created by Shohei Fukui on 2021/04/17.
//  
//

import Foundation
import TogglerCore
import Project
import TimeEntry

public struct FetchTimeEntriesAndProjectsActionAsync: Action {
    public init() {}
}
public func togglMiddleware() -> Middleware<AppState> {
    return {state, action , dispatch in
        switch action {
        case _ as FetchTimeEntriesAndProjectsActionAsync:
            Task {
                do {
                    let entryResult = try await TimeEntryRepository.shared.fetchEntries()
                    dispatch(FetchTimeEntriesAction(timeEntries: entryResult))
                } catch {
                    print("error")
                }
            }
        default:
            break
        }
        print("middleware")
    }
}
