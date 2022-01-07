//
//  TogglReducer.swift
//  Toggler
//
//  Created by Shohei Fukui on 2021/03/23.
//  
//

import Foundation
import TogglerCore
import Project
import TimeEntry

func togglReducer(_ state: TogglState, _ action: Action) -> TogglState {
    var state = state
    switch action {
    case let action as FetchProjectsAction:
        state.projects = action.projects
    case let action as FetchTimeEntriesAction:
        state.timeEntries = action.timeEntries
    default:
        break
    }
    return state
}
