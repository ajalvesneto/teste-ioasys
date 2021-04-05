//
//  Investor.swift
//  Empresas Ioasys
//
//  Created by Antonio Alves on 04/04/21.
//

import Foundation


struct Investor: Codable {
    
    let id: Int
    let investorName: String
    let email: String
    let city: String
    let country: String
    let balance: Double
    let photo: String
    let portfolioValue : Double
    let firstAccess: Bool
    let superAngel: Bool
    
}

enum CodingKeys: String, CodingKey {
    case id,email,city,country,balance,photo
    
    case investorName = "investor_name"
    case portfolioValue = "portfolio_value"
    case firstAccess = "first_access"
    case superAngel = "super_angel"
}
