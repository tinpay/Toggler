//
//  Project.swift
//  Toggler
//
//  Created by Shohei Fukui on 2021/02/22.
//  
//

import Foundation
public struct Project: Decodable {
    public let id: Int
    public let name:String?
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)

    }

}

