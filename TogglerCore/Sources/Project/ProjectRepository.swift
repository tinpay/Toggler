//
//  ProjectRepository.swift
//  
//
//  Created by Shohei Fukui on 2021/09/26.
//  
//
import Foundation
import Moya
import TogglerCore
import Workspace

public class ProjectRepository {
    public static let shared = ProjectRepository()

    public func fetchProjects(completion: @escaping (Result<[Project], Error>) -> Void) {
        WorkspaceRepository.shared.fetchWorkspaces {[weak self] result in
            do {
                if let wid = try result.get().first?.id {
                    self?.fetchProjects(wid: wid, completion: { result in
                        do {
                            let projects = try result.get()
                            completion(.success(projects))
                        }catch {
                            print(error)
                            completion(.failure(error))
                        }
                    })
                }
            }catch {
                print(error)
            }
        }
    }

    private func fetchProjects(wid: Int, completion: @escaping (Result<[Project], Error>) -> Void) {
        let provider = MoyaProvider<Toggl>()
        provider.request(.workspaceProjects(wid)){ result in
            switch result {
            case let .success(response):
                let data = response.data
                do {

                    let result = try JSONDecoder().decode([Project].self, from: data)
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
