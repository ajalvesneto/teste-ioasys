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
    @IBOutlet weak var labelCredenciaisIncorretas: UILabel!
    
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    
    private lazy var networking = Networking()
    
    var button = UIButton();
    let image = UIImage(systemName: "eye.fill")
    
    var imageViewEmail = UIImageView();
    let imageX = UIImage(systemName: "xmark.circle.fill")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.setImage(image, for: .normal)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(toglePassoword(_ :)), for: .touchUpInside)
        
        imageViewEmail.image = imageX
        imageViewEmail.tintColor = .red
        textFieldEmail.rightView = imageViewEmail
        
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
        button.tintColor = .gray
        if textFieldPassword.isSecureTextEntry == true{
            textFieldPassword.isSecureTextEntry = false
            button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
            
        }else{
            textFieldPassword.isSecureTextEntry = true
            button.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        }
    }
    
    @IBAction func doLogin(_ sender: Any) {
       
        
        let path = "https://empresas.ioasys.com.br/api/v1/users/auth/sign_in"
        let headers = ["application/json": "Content-Type"]
        
        
        
        let parameters = ["email" : "\(textFieldEmail.text ?? "testeapple@ioasys.com.br")", "password" : "\(textFieldPassword.text ?? "12341234")"]
        

        
        networking.performRequest(type: ResultModel<Investor>.self, path: path, method: .post, headers: headers, parameters: parameters) { [self] (result, error) in

            if let error = error {
                print(error.localizedDescription)
            } else {
                guard let result = result else { return }
                if(result.success){
                   print("funcionou")
                }else{
                   errorMessage()
                }
            }
        }
        
    }
    
    func errorMessage(){
        
        
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .red
        
        textFieldEmail.layer.borderWidth = 1
        textFieldEmail.layer.cornerRadius = 5
        textFieldEmail.layer.borderColor = .init(red: 1, green: 0, blue: 0, alpha: 1)
        textFieldEmail.rightViewMode = .always
       
        
        textFieldPassword.layer.borderWidth = 1
        textFieldPassword.layer.cornerRadius = 5
        textFieldPassword.layer.borderColor = .init(red: 1, green: 0, blue: 0, alpha: 1)
        
        labelCredenciaisIncorretas.isHidden = false
        
    }
    
    
    
    
    
    



}

