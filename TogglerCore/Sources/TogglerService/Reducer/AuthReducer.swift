//
//  AuthReducer.swift
//  Toggler
//
//  Created by Shohei Fukui on 2021/03/23.
//  
//

import Foundation
import TogglerCore

func authReducer(_ state: AuthState, _ action: Action) -> AuthState {
    // TODO: 認証の処理とかあればかく。tokenを永続化したり。
    var state = state
    switch action {
    default:
        break
    }
    return state
}
