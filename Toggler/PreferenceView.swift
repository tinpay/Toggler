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
                        .padding(.horizontal, 10)
                    TextField("input toggl token", text: $togglToken)
                        .padding(.horizontal, 10)
                }
                NavigationLink {
                    LoginView()
                } label: {
                    HStack {
                        Text("Toggl連携")
                            .font(.body)
                        Spacer()
                        Text("未連携")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }.frame(maxWidth: .infinity)
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
