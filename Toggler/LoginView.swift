//
//  LoginView.swift
//  Toggler
//
//  Created by Shohei Fukui on 2023/01/21.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    var body: some View {
        ZStack {
            Color("base")
            VStack {
                Spacer()
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 64)
                Spacer()
                    .frame(height: 50)
                HStack {
                    TextField(text: $email,
                              label: {
                        Text("メールアドレス").foregroundColor(.white)
                    })

                }
                .padding(10)
                .background(.white.opacity(0.2))
                HStack {
                    SecureField(text: $password,
                                label: {
                        Text("パスワード").foregroundColor(.white)
                    })
                }
                .padding(10)
                .background(.white.opacity(0.2))
                Spacer()
                    .frame(height: 50)
                Button {
                    
                } label: {
                    Text("ログイン")
                        .foregroundColor(.white)
                        .bold()
                    
                }
                .frame(width: 180, height: 50)
                .background(Color("secondary"))
                .cornerRadius(40)
                

                Spacer()
            }
            .padding(.horizontal, 20)
        }.ignoresSafeArea()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
