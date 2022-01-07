//
//  WorkspaceRepository.swift
//  
//
//  Created by Shohei Fukui on 2021/09/26.
//  
//
import Foundation
import Moya
import TogglerCore

public class WorkspaceRepository {
    public static let shared = WorkspaceRepository()

    public func fetchWorkspaces(completion: @escaping (Result<[Workspace], Error>) -> Void) {
        let provider = MoyaProvider<Toggl>()
        provider.request(.workspaces){ result in
            switch result {
            case let .success(response):
                let data = response.data
                do {

                    let result = try JSONDecoder().decode([Workspace].self, from: data)
                    completion(.success(result))
                }catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
