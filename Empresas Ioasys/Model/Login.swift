//
//  ResulModel.swift
//  Empresas Ioasys
//
//  Created by Antonio Alves on 04/04/21.
//

import Foundation


struct Login<T: Decodable>: Decodable {
    var investor: Investor?
    var enterprise : String?
    var success : Bool
    var errors: [String]?
    
    
    enum CodingKeys: String, CodingKey {
        case investor
        case enterprise
        case success
        case errors
    }
}
