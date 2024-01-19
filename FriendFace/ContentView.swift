//
//  ContentView.swift
//  FriendFace
//
//  Created by Zhansen Zhalel on 19.01.2024.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    
    var body: some View {
        NavigationStack {
            List(users) { user in
                NavigationLink(value: user) {
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .fontWeight(.bold)
                        
                        Text(user.isActive ? "Active" : "Not Active")
                            .font(.footnote)
                            .foregroundStyle(user.isActive ? .green : .red)
                    }
                }
            }
            .navigationTitle("FriendFace")
            .navigationDestination(for: User.self) { user in
                DetailUserView(user: user)
            }
            .task {
                if users.isEmpty {
                    await loadUsers()
                }
            }
        }
    }
        
    func loadUsers() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Incorrect response")
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            if let decodedUsers = try decoder.decode([User]?.self, from: data) {
                for user in decodedUsers {
                    modelContext.insert(user)
                }
            } else {
                print("Decoding failed")
            }
        } catch {
            print("Catched error: \(error)")
        }
    }
}

#Preview {
    ContentView()
}
