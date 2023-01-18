//
//  File.swift
//  
//
//  Created by Shohei Fukui on 2021/09/26.
//  
//
import Foundation
import TogglerCore
import Moya

public class TimeEntryRepository {
    public static let shared = TimeEntryRepository()
    
    public func fetchEntries() async throws -> [TimeEntry] {
        let day = Date()
        return try await fetchTimeEntries(today: day)
    }

    private func fetchTimeEntries(today: Date) async throws -> [TimeEntry] {
        return try await withCheckedThrowingContinuation { continuation in
            let provider = MoyaProvider<Toggl>()
            provider.request(.timeEntries(today)){ result in
                switch result {
                case let .success(response):
                    let data = response.data
                    do {
//                        let aaa = String(data: data, encoding: .utf8)
                        let result = try JSONDecoder().decode([TimeEntry].self, from: data)
                        continuation.resume(returning: result)
                    }catch {
                        continuation.resume(throwing: error)
                    }
                case let .failure(error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

}
