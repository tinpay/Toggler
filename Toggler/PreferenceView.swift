//
//  PreferenceView.swift
//  Toggler
//
//  Created by Shohei Fukui on 2021/02/11.
//  
//

import SwiftUI

struct PreferenceView: View {
    @State var togglToken = ""

    // TODO: 適当においただけ。処理もかいてない。
    var body: some View {
        NavigationView {
            List {
                HStack{
                    Text("Toggl Token")
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    TextField("input toggl token", text: $togglToken)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                }
            }
            .navigationTitle("設定")
            .navigationBarItems(trailing: Button(action: {

            }) {
                Text("閉じる")
            }
            )
        }
    }
}

struct PreferenceView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceView()
    }
}
