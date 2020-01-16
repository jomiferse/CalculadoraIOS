//
//  ViewController.swift
//  CalculadoraIOS
//
//  Created by José Miguel Fernández on 10/01/2020.
//  Copyright © 2020 José Miguel Fernández. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var numeroEnPantalla:Double = 0
    var numeroAnterior:Double = 0
    var valorNil: Int?
    var ejecutando = false
    var operacion = 0
    var valor:String = ""
    var positivo = true
    var negativo = false
    var operacionActiva = false
    var memoria:Double = 0
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func numbers(_ sender: UIButton) {
        if (label.text == "0") {
            label.text = ""
        }
        if (ejecutando == true) {
            label.text = String(sender.tag-1)
            numeroEnPantalla = Double(label.text!)!
            ejecutando = false
            operacionActiva = false
        } else {
            label.text = label.text! + String(sender.tag-1)
            numeroEnPantalla = Double(label.text!)!
            operacionActiva = false
        }
    }
    
    @IBAction func buttons(_ sender: UIButton) {
        if label.text != "" && sender.tag != 11 && sender.tag != 16 {
            if sender.tag == 12 && operacionActiva == false {
                numeroAnterior = Double(label.text!)!
                label.text = "/"
                operacionActiva = true
            } else if sender.tag == 13 && operacionActiva == false {
                numeroAnterior = Double(label.text!)!
                label.text = "x"
                operacionActiva = true
            } else if sender.tag == 14 && operacionActiva == false {
                numeroAnterior = Double(label.text!)!
                label.text = "-"
                operacionActiva = true
            } else if sender.tag == 15 && operacionActiva == false {
                numeroAnterior = Double(label.text!)!
                label.text = "+"
                operacionActiva = true
            } else if sender.tag == 21 && label.text != "0" {
                if (positivo == true) {
                    valor = String(label.text!)
                    label.text = "-" + valor
                    positivo = false
                    negativo = true
                } else if (negativo == true) {
                    valor = String(label.text!)
                    valor.removeFirst()
                    label.text = valor
                    positivo = true
                    negativo = false
                }
                
            } else if sender.tag == 22 {
                numeroEnPantalla = Double(label.text!)!
                label.text = String(numeroEnPantalla / 100)
                
            } else if sender.tag == 23 && label.text != "" && label.text != "0" {
                valor = String(label.text!)
                let lastCharIndex = valor.index(before: valor.endIndex)
                valor.remove(at: lastCharIndex)
                label.text = valor
                
                if valor.count==0 {
                    label.text = "0"
                }
            } else if sender.tag == 30 && operacionActiva == false {
                memoria = 0
                self.showToast(message: "Memoria: " + String(memoria))
            } else if sender.tag == 31 {
                if memoria != 0 {
                    label.text = String(memoria)
                } else {
                    label.text = String(memoria)
                    self.showToast(message: "Memoria: " + String(memoria))
                }
            } else if sender.tag == 33 && operacionActiva == false {
                if label.text != "" {
                    memoria = memoria + Double(label.text!)!
                    self.showToast(message: "Memoria: " + String(memoria))
                }
            } else if sender.tag == 32 && operacionActiva == false {
                if label.text != "" {
                    memoria = memoria - Double(label.text!)!
                    self.showToast(message: "Memoria: " + String(memoria))
                }
            }
            operacion = sender.tag
            ejecutando = true;
        } else if sender.tag == 16 {
            if operacion == 12 {
                label.text = String(numeroAnterior / numeroEnPantalla)
            } else if operacion == 13 {
                label.text = String(numeroAnterior * numeroEnPantalla)
            } else if operacion == 14 {
                label.text = String(numeroAnterior - numeroEnPantalla)
            } else if operacion == 15 {
                label.text = String(numeroAnterior + numeroEnPantalla)
            }
        } else if sender.tag == 11 {
            label.text = "0"
            numeroAnterior = 0
            numeroEnPantalla = 0
            operacion = 0
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "0"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func showToast(message : String) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}
