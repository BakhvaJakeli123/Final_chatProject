//
//  DataBaseManager.swift
//  Final_chatProject
//
//  Created by Baxva Jakeli on 25.07.21.
//

import Foundation
import FirebaseDatabase

final class DataBaseManager {
    
    static let shared = DataBaseManager()
    
    private let database = Database.database().reference()
    
    public func insertUser(with user: ChatAppUser) {
        database.child(user.safeEmail).setValue([
            "name": user.name,
            "surname": user.surName
        ])
    }
}

extension DataBaseManager {
    
    public func userExists(with email: String, completion: @escaping ((Bool) -> Void)) {
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value) { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
        }
        
        completion(true)
    }
    
}

struct ChatAppUser {
    let name: String
    let surName: String
    let email: String
    
    var safeEmail: String {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
}
