//
//  ViewController.swift
//  Poker21Marvin
//
//  Created by user177281 on 20/11/2020.
//


import UIKit

class ViewController: UIViewController {
    
    //Relaciona Storyboard con View Controller
    @IBOutlet weak var covA: UICollectionView!
    @IBOutlet weak var covB: UICollectionView!
    @IBOutlet weak var currentView: UIView!
    @IBOutlet weak var lblCurrentNumber: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    
    // Asigno variables globales que se usan para la logica del juego
    
    var viewTimer = UIView()
    let message = UILabel()
    
    // Listas que le asigna al collectionviw, para el de la izquieda y la lista b derecha
    var listA = [Int]()
    var listB = [Int]()
    
    //La variable de la tercera carta que se la asigna el random
    var current: Int?
    
    // Cada que selecciona una carta va contando
    var countCards: Int = 0
    var score: Int = 100
    
    // para usar el contador al momento que va inicar el juego
    var timer: Timer?
    // Para el 3 2 1
    var totalTime = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addCountView()
        initTimer()
        
        reiniciateGame()
        
        
        // Llamadas al delegado y al data source para manejar las funciones del collectionView
        covA.delegate = self
        covA.dataSource = self
        covA.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardCollectionViewCell")
        
        covB.delegate = self
        covB.dataSource = self
        covB.register(UINib(nibName: "CardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardCollectionViewCell")
        
    }
    
    // Funcion creada para reinicar el juego,
    func reiniciateGame() {
        
        // limpiar las listas
        listA = []
        listB = []
        
        //genera random para llenar lista a y lista b
        for _ in 1...10 {
            listA.append(Int.random(in: -21..<21))
        }
        
        for _ in 1...10 {
            listB.append(Int.random(in: -21..<21))
        }
        // Genera un numero aleatorio para que muestre en la tercera carta
        current = Int.random(in: 0..<20)
        
        // Setea la tercera carta
        lblCurrentNumber.text = "\(current ?? 0)"
        
        // Contador de cartas lo iniciliza a 0
        countCards = 0
        
        // El puntaje lo inicializa en 100 como empieza
        score = 100
        // Setea el puntaje
        lblScore.text = "Puntuación: \(score)"
        
        // CollectionView A y CollectiveB  para manejar listas Horizontales
        
        //Refresca la data de las listas
        covA.reloadData()
        covB.reloadData()
        
    }
    
    // Esto hace el conteo de 3 2 1 , dentro del timer hay una funcion
    func initTimer() {
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    // Para agregar vista por programacion
    func addCountView() {
        // obtengo las medidas de la pantalla
        let screenSize: CGRect = UIScreen.main.bounds
        // La variable global le asigna las medidas
        viewTimer = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height))
        // Le pone un fondo a esa vista donde sale el timer(LaOpacidad)
        viewTimer.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        // Agrega como subvista a la vista donde se encuentra
        self.view.addSubview(viewTimer)

        // Asigno color, fuente, y el asigno constrains  y se pone falso para que agregar constraints programaticamente
        message.textColor = .white
        message.font = UIFont.boldSystemFont(ofSize: 50.0)
        message.translatesAutoresizingMaskIntoConstraints = false
        // En caso de que ocupe todo el ancho hace un salto de linea x palabra
        message.lineBreakMode = .byWordWrapping
        // Asigna numero de linea, se pone en 0 , cuando no hay limite de lineas
        message.numberOfLines = 0
        // Alinea al centro
        message.textAlignment = .center
        
        // Ese message se agrega a la vista timer
        viewTimer.addSubview(message)
        
        
        // Asinga el ancho
        message.widthAnchor.constraint(equalTo: viewTimer.widthAnchor).isActive = true
        // Agrega los constraints paras que este centrada
        
        message.centerXAnchor.constraint(equalTo: viewTimer.centerXAnchor).isActive = true
        message.centerYAnchor.constraint(equalTo: viewTimer.centerYAnchor).isActive = true
        
    }
    // Actualiza la fecha , cada vez que se cuenta un segundo se llama a la funcion
    @objc func updateTimer() {
         // Se asigna el tiempo que se asigne
        
        // Hace interpolacion porque la variable totaltime, porque la variable totaltime es entero y los label solo aceptan string,con ese \ para que reciba cualquier tipo de variable
        message.text = "\(totalTime)"
        
        // Validamos si el totaltime sea diferente de 0 y que que sea mayor a 0, si entra le bajas 1 l totaltime
        if totalTime != 0 && totalTime > 0 {
            totalTime -= 1
            // En el caso contrario, primero valido que mi variable local timer no sea nulo,. y si no es nulo, le pregunta si es 0
          //   resta 1 y muestra el mensaje que comienza y si es diferente entonces seteamos el mensaje como vacio, el tiempo seteamos a 3 , el timer lo detengo con la funcion invalidate(), luego seteamos a nulo el timer para que se reinicie
        } else {
            if let timer = self.timer {
                if totalTime == 0 {
                    totalTime -= 1
                    message.text = "COMIENZA!"
                } else {
                    message.text = ""
                    totalTime = 3
                    timer.invalidate()
                    self.timer = nil
                    // Removemos las vistas para poder jugar
                    message.removeFromSuperview()
                    viewTimer.removeFromSuperview()
                }
            }
        }
    }
    
}
// Para ordenar el codigo y trabajar con los delegados del collectionVie usamos el extension (Dividi 2 en dos partes el View Controller)
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    // En esta parte del Viewcontroller uso el UICollectionViewDElegate y el UICollectionViewDataSource
    
    // Funcion que define la cantidad de items dentro del collectionview
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Si detecta queel collectionView es el collectionView A, entonces le dices la cantidad de items dentro de la lista, sino llena el b
        if covA == collectionView {
            return listA.count
        } else {
            return listB.count
        }
    }
    
    // Te llena la celda a cada colelectionview de acuerdo a la lista
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // Validamos si es el collectionview A, y si es lo llenamos
        if collectionView == covA {
            // creamos la variable localCell, loCell y vuelve un objetos de de celda de vista de tabla reutilizable ubicado por su identificador
            
            // usamos el guard para validar la celda en caso sea nulo no va a correr el codigo y retorna un  UICollectionViewCell vacio
            guard let loCell = covA.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as? CardCollectionViewCell else {
                return UICollectionViewCell()
            }
            // Ya tengo la instancia de la celda , solo llamao a la funcion que es propia de la celda
            // Primero le paso el indice
            loCell.setData(current: listA[indexPath.row])
            // Ocultarlo el viererverse en caso sea el ultimo indice,
            // Como es de izquierda a derecha el collectionView , entonces ocultamos todas las celdas que no sean el ultimo item
            loCell.viewReverse.isHidden = (listA.count - 1) == indexPath.row
            // hacemos que el delegado se use en esa vista
            loCell.delegate = self
            // Validacion para que regrese y se ordene y se vaya al final del collectionView
            if listA.count == 10 {
                covA.scrollToItem(at: IndexPath(item: listA.count - 1, section: 0), at: .right, animated: true)
            }
          // retorna la celda
            return loCell
            
            // En caso contrario, llena el collectionviewB
        } else {
            guard let loCell = covB.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as? CardCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            loCell.setData(current: listB[indexPath.row])
            loCell.viewReverse.isHidden = indexPath.row == 0
            loCell.delegate = self
            return loCell
        }
        
    }
    //Función que signa altura y ancho a la celda de ambos collectionview
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: covA.frame.size.height)
    }
    //Funcion que selecciona la celda e identifica y mira si se seleccion ay remueve de la vista y actualiza el collectionView
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if covA == collectionView {
            listA.remove(at: indexPath.row)
            covA.reloadData()
        } else {
            listB.remove(at: indexPath.row)
            covB.reloadData()
        }
    }
    
}
// Es el delegado del cardcell lo implementamos
extension ViewController: CardCellDelegate {
    
    func selectCell(currentNumber: Int) {
        // Cada vez que seleccionamos vamos aumentando en 1 el countcard para ver cuantas cartas se ha seleccionado
        countCards += 1
        // el currentNumber se suma con el numero de la celda
        current = (current ?? 0) + currentNumber
        //la vista del currentNumber que esta en al tercera carta , cambia de de color acuerdo si es menor a 0 o mayor a 0
        currentView.backgroundColor = (current ?? 0) < 0 ? #colorLiteral(red: 0.9411764706, green: 0.4431372549, blue: 0.5019607843, alpha: 1) : #colorLiteral(red: 0, green: 0.5647058824, blue: 0.3176470588, alpha: 1)
        // setea el valor a la tercera carta
        lblCurrentNumber.text = "\(current ?? 0)"
        
        // Validamos si el current es 0
        if (current ?? 0) < 0 {
            // Disminuimos el puntaje cada vez que selecionamos una carta
            score -= 5
            // Seteo el score
            lblScore.text = "Puntuación: \(score)"
            
            // Creo el alert que se llamará en este caso(- 0)
            let alert = UIAlertController(title: "Poker 21", message:  "PERDISTE, INTENTALO DE NUEVO", preferredStyle: .alert)
            //Agrego al alert el poner el nombre el nombre textFiled
            alert.addTextField { (textField) in
                textField.placeholder = "Ingresa tu nombre"
            }
            // Le agrego una accion al alert
            let alertAction = UIAlertAction(title: "Aceptar", style: .default) { (_) in
                let textField = alert.textFields?[0]
                
                
                UserManager.sharedManager.saveUser(name: textField?.text ?? "Sin nombre", score: 0, isWinner: false, completion: { str in
                    
                })
                
                let alert = UIAlertController(title: "Poker 21", message:  "¿Deseas seguir jugando?", preferredStyle: .alert)
                
                let yesAction = UIAlertAction(title: "Sí", style: .default) { (_) in
                    self.reiniciateGame()
                    self.addCountView()
                    self.initTimer()
                }
                
                let noAction = UIAlertAction(title: "No", style: .default) { (_) in
                    self.navigationController?.popViewController(animated: true)
                }
                
                alert.addAction(yesAction)
                alert.addAction(noAction)
                self.present(alert, animated: true, completion: nil)
                
            }
            
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
            
        } else {
            if countCards == 1 && current == 21 {
                let alert = UIAlertController(title: "Poker 21", message: "FELICIDADES GANASTE A LA PRIMERA!, OBTUVISTE EL MEJOR PUNTAJE, 100 PUNTOS!", preferredStyle: .alert)
                
                alert.addTextField { (textField) in
                    textField.placeholder = "Ingresa tu nombre"
                }
                
                let alertAction = UIAlertAction(title: "Aceptar", style: .default) { (_) in
                    let textField = alert.textFields?[0]
                    UserManager.sharedManager.saveUser(name: textField?.text ?? "Sin nombre", score: self.score, isWinner: true, completion: { str in
                        
                    })
                    
                    let alert = UIAlertController(title: "Poker 21", message:  "¿Deseas seguir jugando?", preferredStyle: .alert)
                    
                    let yesAction = UIAlertAction(title: "Sí", style: .default) { (_) in
                        self.reiniciateGame()
                        self.addCountView()
                        self.initTimer()
                    }
                    
                    let noAction = UIAlertAction(title: "No", style: .default) { (_) in
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                    alert.addAction(yesAction)
                    alert.addAction(noAction)
                    self.present(alert, animated: true, completion: nil)
                    
                }
                
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
            } else if current == 21 {
                
                score -= 5
                lblScore.text = "Puntuación: \(score)"
                
                let alert = UIAlertController(title: "Poker 21", message: "FELICIDADES GANASTE, OBTUVISTE UN PUNTAJE DE \(score)", preferredStyle: .alert)
                
                alert.addTextField { (textField) in
                    textField.placeholder = "Ingresa tu nombre"
                }
                
                let alertAction = UIAlertAction(title: "Aceptar", style: .default) { (_) in
                    let textField = alert.textFields?[0]
                    UserManager.sharedManager.saveUser(name: textField?.text ?? "Sin nombre", score: self.score, isWinner: true, completion: { str in
                        
                    })
                    
                    let alert = UIAlertController(title: "Poker 21", message:  "¿Deseas seguir jugando?", preferredStyle: .alert)
                    
                    let yesAction = UIAlertAction(title: "Sí", style: .default) { (_) in
                        self.reiniciateGame()
                        self.addCountView()
                        self.initTimer()
                    }
                    
                    let noAction = UIAlertAction(title: "No", style: .default) { (_) in
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                    alert.addAction(yesAction)
                    alert.addAction(noAction)
                    self.present(alert, animated: true, completion: nil)
                }
                
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
                
            } else if countCards == 20 {
                
                score -= 5
                lblScore.text = "Puntuación: \(score)"
                
                let alert = UIAlertController(title: "Poker 21", message: "PERDISTE, SE TE ACABARON LAS CARTAS, INTENTALO UNA VEZ MÁS!", preferredStyle: .alert)
                
                alert.addTextField { (textField) in
                    textField.placeholder = "Ingresa tu nombre"
                }
                
                let alertAction = UIAlertAction(title: "Aceptar", style: .default) { (_) in
                    let textField = alert.textFields?[0]
                    UserManager.sharedManager.saveUser(name: textField?.text ?? "Sin nombre", score: 0 , isWinner: false, completion: { str in
                        
                    })
                    
                    let alert = UIAlertController(title: "Poker 21", message:  "¿Deseas seguir jugando?", preferredStyle: .alert)
                    
                    
                    let yesAction = UIAlertAction(title: "Sí", style: .default) { (_) in
                        self.reiniciateGame()
                        self.addCountView()
                        self.initTimer()
                    }
                    
                    let noAction = UIAlertAction(title: "No", style: .default) { (_) in
                        self.navigationController?.popViewController(animated: true)
                    }
                    
                    alert.addAction(yesAction)
                    alert.addAction(noAction)
                    self.present(alert, animated: true, completion: nil)
                }
                
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
            } else {
                score -= 5
                lblScore.text = "Puntuación: \(score)"
            }
        }
        
    }
    
}
