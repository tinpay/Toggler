//
//  ReportView.swift
//  Toggler
//
//  Created by Shohei Fukui on 2023/01/22.
//

import SwiftUI
import DomainService

struct ReportView: View {
    @Binding var text: String
    @State var showsActivityView: Bool = false

    var body: some View {
        VStack{
            TextEditor(text: $text)
                .cornerRadius(20)
                .padding(20)
//            Button("Share") {
//                showsActivityView = true
//            }
//            .sheet(isPresented: $showsActivityView) {
//                ActivityView(
//                    activityItems: [text],
//                    applicationActivities: nil
//                )
//            }
        }.background(Color("secondary"))
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        ReportView(text: Binding(get: { "" }, set: { _ in }))
    }
}
