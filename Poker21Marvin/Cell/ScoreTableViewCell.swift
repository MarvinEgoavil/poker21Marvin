//
//  ScoreTableViewCell.swift
//  Poker21Marvin
//
//  Created by user177281 on 20/11/2020.
//

import UIKit

class ScoreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewResult: UIView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(isWinner: Bool, name: String, score: Int) {
        lblName.text = name
        viewResult.backgroundColor = isWinner ? #colorLiteral(red: 0, green: 0.5647058824, blue: 0.3176470588, alpha: 1) : #colorLiteral(red: 0.9411764706, green: 0.4431372549, blue: 0.5019607843, alpha: 1)
        lblScore.text = "\(score)"
    }
    
}
