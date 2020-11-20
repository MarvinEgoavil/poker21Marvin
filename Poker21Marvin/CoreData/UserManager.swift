//
//  UserManager.swift
//  Poker21Marvin
//
//  Created by user177281 on 20/11/2020.
//

import Foundation
import CoreData

///Clase User CORE DATA
class UserManager {
    
    static let sharedManager = UserManager()
    
    private init(){}
    
    let viewContext = AppDelegate().persistentContainer.viewContext
    
    //MARK: SAVE USER
    func saveUser(name: String, score: Int, isWinner: Bool, completion: @escaping (_ result: String?) -> ()) {
        
        let newUser = User(context: viewContext)
        newUser.isWinner = isWinner
        newUser.name = name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "Sin nombre" : name
        newUser.score = Int32(score)
        
        do {
            try viewContext.save()
            completion(nil)
        } catch let error as NSError {
            completion(error.localizedDescription)
        }
    }
    
    var listUsers: [User]? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        let users = try! viewContext.fetch(request)
        if users.count > 0 {
            return users
        }
        return []
    }
    
}
