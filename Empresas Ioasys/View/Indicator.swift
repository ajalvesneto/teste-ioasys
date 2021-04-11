//
//  Indicator.swift
//  Empresas Ioasys
//
//  Created by Antonio Alves on 09/04/21.
//

import Foundation
import UIKit

class Indicator : UIView{

    var spinner = UIActivityIndicatorView(style: .whiteLarge)
    var loadingView = UIView()
    
    
    func showActivityIndicator() {
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
