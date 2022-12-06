//
//  ContentView.swift
//  FriendFace
//
//  Created by Tom LEBRUN on 23/10/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var cachedUsers: FetchedResults<CachedUser>
    
    var body: some View {
        NavigationView {
            List(cachedUsers, id: \.id) { user in
                NavigationLink{
                    DetailedView(user: user)
                } label: {
                    VStack(alignment: .leading) {
                        Text(user.wrappedName)
                        Text(user.wrappedCompany)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("FriendFace")
            .task {
                if users.isEmpty {
                    await loadData()

                    await MainActor.run {
                        for user in users {
                            let newUser = CachedUser(context: moc)
                            newUser.id = user.id
                            newUser.isActive = user.isActive
                            newUser.company = user.company
                            newUser.name = user.name
                            newUser.age = Int16(user.age)
                            newUser.email = user.email
                            newUser.address = user.address
                            newUser.about = user.about
                            newUser.registered = user.registered
                            newUser.tags = user.tags.joined(separator: ",")
                            
                            for friend in user.friends {
                                let newFriend = CachedFriend(context: moc)

                                newFriend.id = friend.id
                                newFriend.name = friend.name
                                
                                newUser.addToFriends(newFriend)
                                
                            }
                            
                            try? moc.save()
                        }
                        print("data loaded in cache")
                    }
                    
                }
            }
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            if let decodedResponse = try? decoder.decode([User].self, from: data) {
                users = decodedResponse
            }
            
        } catch {
            print("Invalid data")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
