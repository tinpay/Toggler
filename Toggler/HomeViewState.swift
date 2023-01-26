////
////  HomeViewState.swift
////  Toggler
////
////  Created by Shohei Fukui on 2023/01/22.
////
//import SwiftUI
//import TogglerService
//import DomainService
//import TimeEntry
//
//@MainActor
//final class HomeViewState: ObservableObject {
//    @EnvironmentObject var store: Store<AppState>
//    @Published private(set) var timeEntry: TimeEntry?
//    
//    let props: Props
//    
//    struct Props {
//        let fetchEntries: () -> ()
//    }
//    
//    func map(state: TogglState) -> Props {
//        return Props(fetchEntries: {
//            self.store.dispatch(action: FetchTimeEntriesAndProjectsActionAsync())
//        })
//    }
//    
//    init() {
//        props = map(state: store.state.togglState)
//    }
//}
