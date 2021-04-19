//
//  TogglMiddleware.swift
//  Toggler
//
//  Created by Shohei Fukui on 2021/04/17.
//  
//

import Foundation
struct FetchTimeEntriesAndProjectsActionAsync: Action {
}
func togglMiddleware() -> Middleware<AppState> {
    return {state, action , dispatch in
        switch action {
        case _ as FetchTimeEntriesAndProjectsActionAsync:

            // fetch All Projects
            TogglRepository.shared.fetchProjects { projectResult in
                // fetch All TimeEntries
                TogglRepository.shared.fetchEntries { entryResult in
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
