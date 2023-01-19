//
//  Organization.swift
//  
//
//  Created by Shohei Fukui on 2023/01/19.
//

public struct Organization: Decodable {
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
