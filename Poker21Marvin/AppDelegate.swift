//
//  AppDelegate.swift
//  Poker21Marvin
//
//  Created by user177281 on 20/11/2020.
//

import UIKit


// Importo la Librería CoreData
import CoreData

//
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    //Creo una variable de tipo persistentContainer, para cargar la persistencia de datos
    
     var persistentContainer: NSPersistentContainer = {
        // Le ponemos de nombre a la base de datos ExampleModel
        let container = NSPersistentContainer(name: "BaseDatos")
        // Cargamos la persistencia y en el carro de error te bota una excepcion
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unsolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }
    // Esta funcion es para guardar el contexto  y esta funcion ser agrega en apllicationWillTerminate, quiere decir cuando va aterminar se guarda el contexto
    
    func saveContext() {
        // creo la variable para guardar el contexto
        let context = persistentContainer.viewContext
        // Si hay cambios guardas, y usamos el do catch para manejar la exepcion en el caso de que no  guarde correctamente los cambios
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unsolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
