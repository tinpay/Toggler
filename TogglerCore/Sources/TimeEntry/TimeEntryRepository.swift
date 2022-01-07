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

    public func fetchEntries(completion: @escaping (Result<[TimeEntry], Error>) -> Void) {
        let day = Date()
        TimeEntryRepository.shared.fetchTimeEntries(today: day, completion: { result in
            do {
                let timeEntries = try result.get()
                completion(.success(timeEntries))

            }catch {
                print(error)
            }
        })
    }

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
}
