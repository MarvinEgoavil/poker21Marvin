//
//  ScoreViewController.swift
//  Poker21Marvin
//
//  Created by user177281 on 12/11/2020.
//

import UIKit

// Es el viewControler  donde se refleja los puntajes, este es un View Controller, dentro ponemos uhn tableviewController para listar los usuarios con sus puntajes respectivos
class ScoreViewController: UIViewController {

    //Hago una referencia del Storyboard al view controller
    @IBOutlet weak var tbScore: UITableView!

    // Creamos una lista de tipo user del modelo de coredata
     var userList = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tbScore.delegate = self
        tbScore.dataSource = self
        tbScore.register(UINib(nibName: "ScoreTableViewCell", bundle: nil), forCellReuseIdentifier: "ScoreTableViewCell")
        
        //Asignamos la lista de usuarios del coredata a la variable userlist, en caso sea nula que sea vacio
        userList = UserManager.sharedManager.listUsers ?? []
        
    }

}

// Hacemos una extension  para incluir los delegados del tableViewcontroller
extension ScoreViewController: UITableViewDelegate, UITableViewDataSource {
    // asiganmos el numero o cantidad de items de la lista
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    // creamos la variable loCell, loCell y vuelve un objetos de de celda de vista de tabla reutilizable ubicado por su identificador
    
    // usamos el guard para validar la celda en caso sea nulo no va a correr el codigo y retorna un  UITableViewCell vacio
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let loCell = tbScore.dequeueReusableCell(withIdentifier: "ScoreTableViewCell", for: indexPath) as? ScoreTableViewCell else {
            return UITableViewCell()
        }
        // llena los datos a la celda
        let user = userList[indexPath.row]
        loCell.setData(isWinner: user.isWinner, name: user.name ?? "", score: Int(user.score))
        return loCell
        
    }
    
    
}
