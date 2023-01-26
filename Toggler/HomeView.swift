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
import TimeEntry

struct HomeView: View {

    @EnvironmentObject var store: Store<AppState>
    @State var showsPreferenceView: Bool = false
    @State var entriesString: String = ""
    @State var selection: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    @State private var currentIndex = 0

    @State private var isSheetPresented = false
    @State private var text = ""
    
    struct Props {
        let timeEntry: String?
        let loaded: Binding<Bool>
        let fetchEntries: () -> ()
    }

    private func map(state: TogglState) -> Props {
        let timeEntry = state.timeEntries.isEmpty ? "" : MessageDomainService.makeEntriesString(date: Date(),timeEntries: state.timeEntries)
        
        return Props(timeEntry: timeEntry,
                     loaded: Binding(
                        get: {
                            timeEntry == nil
                        }, set: { Value, Transaction in
                            
                        }),
                     fetchEntries: {
            store.dispatch(action: FetchTimeEntriesAndProjectsActionAsync())
        })
    }

    var body: some View {

        let props = map(state: store.state.togglState)

        NavigationView{
            // スライドするPickerを一旦コメントアウト
//                VStack {
//                    Picker("aaa", selection: $selection) {
//                        Text("入力する").tag(0)
//                        Text("報告する").tag(1)
//                    }.pickerStyle(.segmented)
//                    GeometryReader { geometory in
//                        HStack(spacing: 0) {
//                            ReportView(text: $entriesString)
//                                .frame(width: geometory.size.width)
//                            InputView()
//                                .frame(width: geometory.size.width)
//                        }
//                        .offset(x: dragOffset)
//                        .offset(x: -CGFloat(selection) * geometory.size.width )
//                        .animation(.linear(duration: 0.2), value: CGFloat(selection) * geometory.size.width)
//                    }
//
//                    Button {
//                        isSheetPresented.toggle()
//                    } label: {
//                        Text("aaa").redacted(reason: .placeholder)
//                    }
//            }
            VStack{
                Text(props.timeEntry ?? "")
                Spacer()
            }
            .navigationBarTitle("Toggl", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                showsPreferenceView.toggle()
            }){
                Image(systemName: "gearshape")
            }.sheet(isPresented: $showsPreferenceView) {
                PreferenceView()
            },trailing: Button(action: {
                props.fetchEntries()
            }){
                Image(systemName: "arrow.clockwise")
            })
        }
        .onAppear {
            props.fetchEntries()
        }
        .sheet(isPresented: $isSheetPresented) {
            TextField(text: $text) {
                
            }.presentationDetents([.fraction(0.1), .height(120), .height(300), .height(500), .large])
                .presentationDragIndicator(.visible)
                .background(.red)
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
        let store = Store(reducer: appReducer, state: AppState(), middlewares:[togglMiddleware()] )
        HomeView().environmentObject(store)
    }
}
