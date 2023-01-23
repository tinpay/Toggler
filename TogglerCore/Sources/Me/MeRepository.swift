//
//  MeRepository.swift
//  
//
//  Created by Shohei Fukui on 2023/01/22.
//

import Foundation
import TogglerCore
import Moya

public class MeRepository {
    public static let shared = MeRepository()
    
    public func fetchMe() async throws -> Me {
        return try await withCheckedThrowingContinuation { continuation in
            let provider = MoyaProvider<Toggl>()
            provider.request(.me){ result in
                switch result {
                case let .success(response):
                    let data = response.data
                    do {
                        let result = try JSONDecoder().decode(Me.self, from: data)
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
