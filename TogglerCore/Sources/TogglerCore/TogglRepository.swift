//
//  TogglRepository.swift
//  Toggler
//
//  Created by Shohei Fukui on 2021/02/03.
//  
//
import Foundation
import Moya

public enum Toggl {
    case timeEntries(Date)
    case workspaces
    case workspaceProjects(Int)
}
extension Toggl: TargetType {
    public var sampleData: Data {
        let path = Bundle.main.path(forResource: "samples", ofType: "json")!
        return FileHandle(forReadingAtPath: path)!.readDataToEndOfFile()
    }

    public var baseURL: URL  { return URL(string: "https://api.track.toggl.com/api/v9")! }

    public var path: String {
        switch self {
        case .timeEntries:
            return "/me/time_entries"
        case .workspaces:
            return "/organizations/600364/workspaces"
        case .workspaceProjects(let wid):
            return "/workspaces/\(wid)/projects"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .timeEntries:
            return .get
        case .workspaces:
            return .get
        case .workspaceProjects:
            return .get
        }

    }

    public var task: Task {
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

    public var headers: [String : String]? {
        let username = "<<トークンをいれる>>"
        let password = "api_token"
        let loginString = "\(username):\(password)"
        let loginData = loginString.data(using: .utf8)
        let base64LoginString = loginData?.base64EncodedString()

        return ["Content-Type": "application/json",
                "Authorization": "Basic \(base64LoginString!)"
        ]
    }
}

public class TogglRepository {
    public static let shared = TogglRepository()

}
