//
//  ScoreViewController.swift
//  Poker21Marvin
//
//  Created by user177281 on 20/11/2020.
//

import UIKit

class ScoreViewController: UIViewController {

    @IBOutlet weak var tbScore: UITableView!

    fileprivate var userList = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tbScore.delegate = self
        tbScore.dataSource = self
        tbScore.register(UINib(nibName: "ScoreTableViewCell", bundle: nil), forCellReuseIdentifier: "ScoreTableViewCell")
        
        userList = UserManager.sharedManager.listUsers ?? []
        
    }

}

extension ScoreViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let loCell = tbScore.dequeueReusableCell(withIdentifier: "ScoreTableViewCell", for: indexPath) as? ScoreTableViewCell else {
            return UITableViewCell()
        }
        
        let user = userList[indexPath.row]
        loCell.setData(isWinner: user.isWinner, name: user.name ?? "", score: Int(user.score))
        return loCell
        
    }
    
    
}
