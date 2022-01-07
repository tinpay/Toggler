//
//  Store.swift
//  Toggler
//
//  Created by Shohei Fukui on 2021/03/22.
//  
//

import Foundation
import Workspace
import Project
import TimeEntry
import TogglerCore

public typealias Dispatcher = (Action) -> Void
public typealias Reducer<State: ReduxState> =  (_ state: State, _ action: Action) -> State
public typealias Middleware<StoreState: ReduxState> = (StoreState, Action, @escaping Dispatcher) -> Void

public protocol ReduxState {}

// State
public struct AppState: ReduxState {
    public var authState = AuthState()
    public var togglState = TogglState()

    public init() {}

//    var contentViewState = ContentViewState()
}

public struct AuthState: ReduxState {
    var token: String = ""
}

public struct TogglState: ReduxState {
    public var workspace: Workspace?
    public var projects: [Project] = []
    public var timeEntries: [TimeEntry] = []
    public var output: String = ""
}

// Store
public class Store<StoreState: ReduxState>: ObservableObject {
    var reducer: Reducer<StoreState>
    @Published public var state: StoreState
    var middlewares: [Middleware<StoreState>]
    public init(reducer: @escaping Reducer<StoreState>, state: StoreState,
         middlewares: [Middleware<StoreState>] = []) {
        self.reducer = reducer
        self.state = state
        self.middlewares = middlewares
    }

    public func dispatch(action: Action) {
        DispatchQueue.main.async {
            self.state = self.reducer(self.state, action)
        }

        self.middlewares.forEach { middleware in
            middleware(state, action, dispatch)
        }
    }
}
