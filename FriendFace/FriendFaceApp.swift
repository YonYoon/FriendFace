//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Zhansen Zhalel on 19.01.2024.
//

import SwiftData
import SwiftUI

@main
struct FriendFaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
