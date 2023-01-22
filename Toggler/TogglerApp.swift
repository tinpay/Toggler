//
//  TogglerApp.swift
//  Toggler
//
//  Created by Shohei Fukui on 2021/02/03.
//  
//

import SwiftUI
import TogglerService

@main
struct TogglerApp: App {
    var body: some Scene {
        let store = Store(reducer: appReducer, state: AppState(), middlewares:[togglMiddleware()] )

        WindowGroup {
            HomeView().environmentObject(store)
        }
    }
}
