//
//  CachedUser+CoreDataProperties.swift
//  FriendFace
//
//  Created by Tom LEBRUN on 25/10/2022.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var friends: NSSet?

    public var wrappedName: String {
        name ?? "No name"
    }
    
    public var wrappedTags: String{
        tags ?? "No tags"
    }
        
    public var wrappedCompany: String {
        company ?? "No job"
    }

    public var wrappedAbout: String {
        about ?? "No data"
    }

    public var wrappedAddress: String {
        address ?? "Homeless"
    }

    public var wrappedEmail: String {
        email ?? "No email"
    }

    public var wrappedRegistered: Date {
        registered ?? Date()
    }

    public var friendsArray: [CachedFriend] {
        let set = friends as? Set<CachedFriend> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}

// MARK: Generated accessors for friends
extension CachedUser {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CachedFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CachedFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
