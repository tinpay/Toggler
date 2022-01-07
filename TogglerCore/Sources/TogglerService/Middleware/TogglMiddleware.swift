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

            // fetch All Projects
            ProjectRepository.shared.fetchProjects { projectResult in
                // fetch All TimeEntries
                TimeEntryRepository.shared.fetchEntries { entryResult in
                    do {
                        dispatch(FetchProjectsAction(projects: try projectResult.get()))
                        dispatch(FetchTimeEntriesAction(timeEntries: try entryResult.get()))
                    }catch {

                    }
                }
            }
        default:
            break
        }
        print("middleware")
    }
}
