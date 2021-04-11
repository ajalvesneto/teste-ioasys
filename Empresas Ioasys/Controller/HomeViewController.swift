//
//  HomeTableViewTableViewController.swift
//  Empresas Ioasys
//
//  Created by Antonio Alves on 06/04/21.
//

import UIKit

class HomeViewController: UIViewController{
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelCountResult: UILabel!
    
    @IBOutlet weak var labelMsg: UILabel!
    
    private lazy var networking = Networking()
    
    var enterprises : [Enterprise] = []{
    didSet {
        self.tableView.reloadData()
        labelCountResult.text = "\(enterprises.count) resultados encontrados"
        togleTableView()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.delegate = self
        searchBar.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        self.view.frame.origin.y = 0 - 100
        
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
      self.view.frame.origin.y = 0
    }
}


extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.enterprises.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let enterprise = enterprises[indexPath.row]
        let details = self.storyboard?.instantiateViewController(withIdentifier: "details")
        navigationController?.pushViewController(details!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        
        
         
        guard let photo =  enterprises[indexPath.section].photo else {
            return cell
        }
        
        let imageUrlString = "https://empresas.ioasys.com.br/\(photo)"
        let imageUrl: URL = URL(string: imageUrlString)!
        cell.ImageViewCell?.loadImage(withUrl: imageUrl)
        cell.LabelViewCell?.text = enterprises[indexPath.row].enterpriseName.uppercased()
        
        return cell
    }
    
    
}


extension HomeViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.text = nil
        searchBar.endEditing(true)
        enterprises.removeAll()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard searchText.count >= 3 else {
            return
        }
        
        guard let uid = UserDefaults.standard.string(forKey: "uid") else {return }
        guard let client = UserDefaults.standard.string(forKey: "client") else {return }
        guard let token = UserDefaults.standard.string(forKey: "token") else {return }
       
        let path = "https://empresas.ioasys.com.br/api/v1/enterprises?name=\(searchText)"
        let headers = ["Content-Type":"application/json", "access-token" : "\(token)", "client" : "\(client)", "uid" : "\(uid) "]
        
        networking.performRequest(type: EnterpriseResponse<Enterprise>.self, path: path, method: .get, headers: headers) { [self] (result, error) in

            if let error = error {
                print(error)//self.alertMessage(message: error.localizedDescription)
            } else {
                setEnterprises(result!.enterprises ?? [])
            }
        }
    }
    
    func setEnterprises(_ enterprises: [Enterprise]) {
        self.enterprises = enterprises
    }
    
    
    func togleTableView(){
        if enterprises.count > 0{
            tableView.isHidden = false
            labelMsg.isHidden = true
        }else{
            tableView.isHidden = true
            labelMsg.isHidden = false
        }
    }
    
    
    
}

extension UIImageView {
    func loadImage(withUrl url: URL) {
           DispatchQueue.global().async { [weak self] in
               if let imageData = try? Data(contentsOf: url) {
                   if let image = UIImage(data: imageData) {
                       DispatchQueue.main.async {
                           self?.image = image
                       }
                   }
               }
           }
       }
}

