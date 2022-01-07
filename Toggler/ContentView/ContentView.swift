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

struct ContentView: View {

    @EnvironmentObject var store: Store<AppState>
    @State var showsActivityView: Bool = false
    @State var showsPreferenceView: Bool = false

    struct Props {
        @State var entriesString: String = ""
        let fetchEntries: () -> ()
    }

    private func map(state: TogglState) -> Props {
        let entriesString = state.timeEntries.isEmpty ? "<empty>" : MessageDomainService.makeEntriesString(date: Date(), projects: state.projects, timeEntries: state.timeEntries)
        return Props(entriesString: entriesString, fetchEntries: {
            store.dispatch(action: FetchTimeEntriesAndProjectsActionAsync())
        })
    }

    var body: some View {

        // TODO: 起動時に表示されるようにする

        let props = map(state: store.state.togglState)

        NavigationView{
            VStack{
                NavigationLink(
                    destination:  PreferenceView(),
                    label: {
                        /*@START_MENU_TOKEN@*/Text("Navigate")/*@END_MENU_TOKEN@*/
                    })
                TextEditor(text: props.$entriesString)
                Button("Share") {
                    showsActivityView = true
                }
                .sheet(isPresented: $showsActivityView) {
                        ActivityView(
                            activityItems: [props.entriesString],
                            applicationActivities: nil
                        )
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
        ContentView()
    }
}
