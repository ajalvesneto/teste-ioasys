//
//  DetailsViewController.swift
//  
//
//  Created by Antonio Alves on 11/04/21.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var selectedEnterpise : Enterprise? = nil
    
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageLogo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        labelName.text = selectedEnterpise?.enterpriseName
        labelDescription.text = selectedEnterpise?.enterprisDescription
        
        guard let photo =  selectedEnterpise?.photo else {
            return
        }
        
        let imageUrlString = "https://empresas.ioasys.com.br/\(photo)"
        let imageUrl: URL = URL(string: imageUrlString)!
        imageLogo.loadImage(withUrl: imageUrl)
        
        // Do any additional setup after loading the view.
    }

    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}



