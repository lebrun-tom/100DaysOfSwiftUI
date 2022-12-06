//
//  DetailedView.swift
//  FriendFace
//
//  Created by Tom LEBRUN on 23/10/2022.
//

import SwiftUI

struct DetailedView: View {
    let user: CachedUser
    
    var random = Int.random(in: 0..<9)
    
    var body: some View {
        Group {
            VStack{
                Image("pp_\(random)")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(height: 250)
                
                Text(user.isActive ? "Online" : "Offline")
                    .padding(5)
                    .foregroundColor(.white)
                    .background(user.isActive ? .green : .red)
                    .clipShape(Capsule())
                    .padding(.horizontal, 100)
                
                Text(user.wrappedEmail)
                    .foregroundColor(.secondary)
            }
            Form {
                Section {
                    ScrollView(.horizontal){
                        HStack {
                            ForEach(user.wrappedTags.components(separatedBy: ","), id: \.self) { tag in
                                Text(tag)
                                    .padding(.horizontal)
                                    .foregroundColor(.white)
                                    .background(.blue)
                                    .clipShape(Capsule())
                                
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                } header : {
                    Text("Tags")
                }
                
                Section {
                    Text(String(user.age))
                } header: {
                    Text("Age")
                }
                
                Section {
                    Text(user.wrappedCompany)
                } header: {
                    Text("Company")
                }
                
                Section {
                    Text(user.wrappedAddress)
                } header: {
                    Text("Adress")
                }
                
                Section {
                    Text(user.wrappedAbout)
                } header: {
                    Text("About")
                }
                //
                Section {
                    Text("\(user.wrappedRegistered.formatted(.dateTime))")
                } header: {
                    Text("Registered")
                }
                
                Section {
                    ForEach(user.friendsArray, id: \.id) { friend in
                        Text(friend.wrappedName)
                    }
                } header: {
                    Text("Friends")
                    
                }
            }
        }
        .navigationTitle(user.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
    }
}
