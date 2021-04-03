//
//  ViewController.swift
//  Empresas Ioasys
//
//  Created by Antonio Alves on 02/04/21.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var labelBemVindo: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var buttonSenha: UITextField!
    @IBOutlet weak var labelSenha: UILabel!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    var button = UIButton();
    let image = UIImage(systemName: "eye.fill")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.setImage(image, for: .normal)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(toglePassoword(_ :)), for: .touchUpInside)
        textFieldPassword.rightView = button
        textFieldPassword.rightViewMode = .always
       
        
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {

      
      // move the root view up by the distance of keyboard height
        let color =  UIColor(red: 0xE0/255,
                            green: 0x1E/255,
                            blue: 0x69/255,
                            alpha: 1.0)
        self.view.frame.origin.y = 0 - 50
        labelEmail.textColor = color
        labelSenha.textColor = color
        labelBemVindo.isHidden = true
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
      self.view.frame.origin.y = 0
        labelBemVindo.isHidden = false
        labelEmail.textColor = .darkGray
        labelSenha.textColor = .darkGray
    }
    
    @objc func toglePassoword(_ sender: Any){
        if textFieldPassword.isSecureTextEntry == true{
            textFieldPassword.isSecureTextEntry = false
            button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        }else{
            textFieldPassword.isSecureTextEntry = true
            button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        }
    }


}

