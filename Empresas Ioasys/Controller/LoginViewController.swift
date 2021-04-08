//
//  ViewController.swift
//  Empresas Ioasys
//
//  Created by Antonio Alves on 02/04/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    
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
    
    var spinner = UIActivityIndicatorView(style: .whiteLarge)
    var loadingView: UIView = UIView()

    
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
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
        let headers = ["Content-Type" : "application/json"]
        
        let parameters = ["email" : "\(textFieldEmail.text!)", "password" : "\(textFieldPassword.text!)"]
        
        showActivityIndicator()
        
        
        networking.performRequest(type: Login<Investor>.self, path: path, method: .post, headers: headers, parameters: parameters) { [self] (result, error) in
            hideActivityIndicator()
            if let error = error {
                print(error)
            } else {
                
                guard let result = result else { return }
                if(result.success){
                    let home = self.storyboard?.instantiateViewController(withIdentifier: "home")
                    navigationController?.pushViewController(home!, animated: true)
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
    
    func showActivityIndicator() {
            self.loadingView = UIView()
            self.loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
            self.loadingView.center = self.view.center
            self.loadingView.backgroundColor = .gray
            self.loadingView.alpha = 0.7
            self.loadingView.clipsToBounds = true
            self.loadingView.layer.cornerRadius = 10

            self.spinner = UIActivityIndicatorView(style: .whiteLarge)
            self.spinner.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
            self.spinner.center = CGPoint(x:self.loadingView.bounds.size.width / 2, y:self.loadingView.bounds.size.height / 2)

            self.loadingView.addSubview(self.spinner)
            self.view.addSubview(self.loadingView)
            self.spinner.startAnimating()
    }

    func hideActivityIndicator() {
            self.spinner.stopAnimating()
            self.loadingView.removeFromSuperview()
    }
    
    
    
    
    
    
    



}

