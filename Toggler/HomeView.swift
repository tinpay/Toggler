//
//  ContentView.swift
//  Toggler
//
//  Created by Shohei Fukui on 2021/02/03.
//  
//

import SwiftUI
import TogglerService
import DomainService

struct HomeView: View {

    @EnvironmentObject var store: Store<AppState>
    @State var showsPreferenceView: Bool = false
    @State var entriesString: String = ""
    @State var selection: Int = 0

    struct Props {
        let fetchEntries: () -> ()
    }

    private func map(state: TogglState) -> Props {
        return Props(fetchEntries: {
            store.dispatch(action: FetchTimeEntriesAndProjectsActionAsync())
        })
    }

    var body: some View {

        // TODO: 起動時に表示されるようにする

        let props = map(state: store.state.togglState)

        NavigationView{
            VStack {
                Picker("aaa", selection: $selection) {
                    Text("入力する").tag(0)
                    Text("報告する").tag(1)
                }.pickerStyle(.segmented)
                if selection == 0 {
                    InputView()
                } else {
                    ReportView(text: $entriesString)
                }
            }
            .navigationBarTitle("Toggl", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                showsPreferenceView.toggle()
            }){
                Image(systemName: "gearshape")
            }.sheet(isPresented: $showsPreferenceView) {
                PreferenceView()
            },

            trailing: Button(action: {
                props.fetchEntries()
            }){
                Image(systemName: "arrow.clockwise")
            })
        }
        .onAppear {
//            let entriesString = state.timeEntries.isEmpty ? "" : MessageDomainService.makeEntriesString(date: Date(), projects: state.projects, timeEntries: state.timeEntries)
        }
    }
}

struct ActivityView: UIViewControllerRepresentable {

    let activityItems: [Any]
    let applicationActivities: [UIActivity]?

    func makeUIViewController(
        context: UIViewControllerRepresentableContext<ActivityView>
    ) -> UIActivityViewController {
        return UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities
        )
    }

    func updateUIViewController(
        _ uiViewController: UIActivityViewController,
        context: UIViewControllerRepresentableContext<ActivityView>
    ) {

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
