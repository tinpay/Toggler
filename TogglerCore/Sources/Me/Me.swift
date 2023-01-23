//
//  Me.swift
//  
//
//  Created by Shohei Fukui on 2023/01/22.
//

public struct Me: Codable {
    public let fullname:String
    
    enum CodingKeys: String, CodingKey {
        case fullname
    }
    
}
