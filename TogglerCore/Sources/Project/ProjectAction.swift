//
//  ProjectAction.swift
//  
//
//  Created by Shohei Fukui on 2021/09/26.
//  
//

import TogglerCore

public struct FetchProjectsAction: Action {
    public let projects: [Project]
    public init(projects: [Project]){
        self.projects = projects
    }
}
