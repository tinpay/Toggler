//
//  TogglRepository.swift
//  Toggler
//
//  Created by Shohei Fukui on 2021/02/03.
//  
//
import Foundation
import Moya


enum Toggl {
    case timeEntries(Date)
    case workspaces
    case workspaceProjects(Int)
}
extension Toggl: TargetType {
    var sampleData: Data {
        let path = Bundle.main.path(forResource: "samples", ofType: "json")!
        return FileHandle(forReadingAtPath: path)!.readDataToEndOfFile()
    }

    var baseURL: URL  { return URL(string: "https://api.track.toggl.com/api/v8")! }

    var path: String {
        switch self {
        case .timeEntries:
            return "/time_entries"
        case .workspaces:
            return "/workspaces"
        case .workspaceProjects(let wid):
            return "/workspaces/\(wid)/projects"
        }
    }
    var method: Moya.Method {
        switch self {
        case .timeEntries:
            return .get
        case .workspaces:
            return .get
        case .workspaceProjects:
            return .get
        }

    }

    var task: Task {
        switch self {
        case .timeEntries(let today):
            let dateFormatter = ISO8601DateFormatter()
            let startToday = Calendar(identifier: .gregorian).startOfDay(for: today)
            let startTomorrow = Calendar.current.date(byAdding: .day, value: 1, to: startToday)!
            let startDate = dateFormatter.string(from: startToday)
            let endDate = dateFormatter.string(from: startTomorrow)

            return .requestParameters(parameters: ["start_date": startDate,
                                                   "end_date": endDate],
                                      encoding: URLEncoding.queryString)
        case .workspaces:
            return .requestPlain
        case .workspaceProjects:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        let username = "<<Toggl API Token>>"
        let password = "api_token"
        let loginString = "\(username):\(password)"
        let loginData = loginString.data(using: .utf8)
        let base64LoginString = loginData?.base64EncodedString()

        return ["Content-Type": "application/json",
                "Authorization": "Basic \(base64LoginString!)"
        ]
    }
}

class TogglRepository {
    static let shared = TogglRepository()

    // MARK: - Public

    func fetchEntries(completion: @escaping (Result<[TimeEntry], Error>) -> Void) {
        let day = Date()
        TogglRepository.shared.fetchTimeEntries(today: day, completion: { result in
            do {
                let timeEntries = try result.get()
                completion(.success(timeEntries))

            }catch {
                print(error)
            }
        })
    }

    func fetchProjects(completion: @escaping (Result<[Project], Error>) -> Void) {
        fetchWorkspaces {[weak self] result in
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

    // MARK: - Private

    private func fetchTimeEntries(today: Date, completion: @escaping (Result<[TimeEntry], Error>) -> Void) {
        let provider = MoyaProvider<Toggl>()
        provider.request(.timeEntries(today)){ result in
            switch result {
            case let .success(response):
                let data = response.data
                do {
                    let result = try JSONDecoder().decode([TimeEntry].self, from: data)
                    completion(.success(result))
                }catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    private func fetchWorkspaces(completion: @escaping (Result<[Workspace], Error>) -> Void) {
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
