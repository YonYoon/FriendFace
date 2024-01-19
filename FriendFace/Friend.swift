//
//  Friend.swift
//  FriendFace
//
//  Created by Zhansen Zhalel on 19.01.2024.
//

import Foundation

class Friend: Codable, Identifiable {
    let id: String
    let name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}
