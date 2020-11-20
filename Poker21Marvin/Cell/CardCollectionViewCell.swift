//
//  CardCollectionViewCell.swift
//  Poker21Marvin
//
//  Created by user177281 on 15/11/2020.
//

import UIKit

// El delegado es para cada vez que se hace click a la celda
protocol CardCellDelegate {
    
    // llama a la funcion de ese delegado
    func selectCell(currentNumber: Int)
}
// Personalizamos nuestras celdas
class CardCollectionViewCell: UICollectionViewCell {
    
    // Referencias de las vistas del storyboard a las clases
    
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var viewReverse: UIView!
    
    // declaro las variable a usar
    var delegate: CardCellDelegate?
    var currentNumber: Int?
    
    //Recibe el numero currentNumber y de acuerdo a eso valida , el el correct number lo pinta rosa y si es mayor verde y seteo el label con el numero que me manda por parametro
    func setData(current: Int) {
        currentNumber = current
        viewCell.backgroundColor = current < 0 ? #colorLiteral(red: 0.9411764706, green: 0.4431372549, blue: 0.5019607843, alpha: 1) : #colorLiteral(red: 0, green: 0.5647058824, blue: 0.3176470588, alpha: 1)
        lblNumber.text = "\(current)"
    }
    
    // Hereda del collectionView , detecta si ha sido selecionado o no la celda
    
    override var isSelected: Bool {
        // el didSet está en el espera para ver si cambia de estado, detecta si ha sido cambiado el booleano a true or false-
        didSet{
            if self.isSelected {
                //Si es verdadero se llama al delegado.
                delegate?.selectCell(currentNumber: currentNumber ?? 0)
            }
        }
    }
    
}
