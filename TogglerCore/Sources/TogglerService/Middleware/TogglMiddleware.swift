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
import Me

public struct FetchTimeEntriesAndProjectsActionAsync: Action {
    public init() {}
}

public struct GetMeAction: Action {
    let email: String
    let password: String
    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }
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
        case let action as GetMeAction:
            Task {
                do {
                    let result = try await MeRepository.shared.fetchMe()
                    dispatch(GetMeAction(email: action.email, password: action.password))
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
