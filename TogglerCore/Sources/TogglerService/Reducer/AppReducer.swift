//
//  AppReducer.swift
//  Toggler
//
//  Created by Shohei Fukui on 2021/03/23.
//  
//

import Foundation
import TogglerCore

public func appReducer(_ state: AppState, _ action: Action) -> AppState {
    var state = state
    state.authState = authReducer(state.authState, action)
    state.togglState = togglReducer(state.togglState, action)
    return state
}
