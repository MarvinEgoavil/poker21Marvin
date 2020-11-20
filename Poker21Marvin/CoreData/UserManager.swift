//
//  UserManager.swift
//  Poker21Marvin
//
//  Created by user177281 on 19/11/2020.
//

import Foundation
import CoreData

///Clase User CORE DATA

// Creamos la clase UserManager, esta clase la usamos cuando guardamos un ususario y cuando listamos los usuarios
class UserManager {
    
    // Hace instancia estatica del userManager
    static let sharedManager = UserManager()
    
    // Se pone este constructor vacio, para que instancia una sola vez
    private init(){}
    
    //Trae el contaxto del core data
    
    let viewContext = AppDelegate().persistentContainer.viewContext
    
    // Crea una funcion que guarda el usuario
    func saveUser(name: String, score: Int, isWinner: Bool, completion: @escaping (_ result: String?) -> ()) {
        // creamos una instancia del usuario y le pasamos el contexto
        let newUser = User(context: viewContext)
        
        // El usuario lo lleno con los parametros
        newUser.isWinner = isWinner
        newUser.name = name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "Sin nombre" : name
        newUser.score = Int32(score)
        //Aplicamos el bloque Do cath para manejar cualquie excepcion
        do {
            try viewContext.save()
            completion(nil)
        } catch let error as NSError {
            completion(error.localizedDescription)
        }
    }
    // Creamos una variable que nos devuelve la lista de usuarios que esta guardado en coredata
    var listUsers: [User]? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        let users = try! viewContext.fetch(request)
        if users.count > 0 {
            return users
        }
        return []
    }
    
}
