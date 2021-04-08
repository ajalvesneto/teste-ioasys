//
//  Portfolio.swift
//  Empresas Ioasys
//
//  Created by Antonio Alves on 06/04/21.
//

import Foundation

struct Portfolio: Codable {
    let enterprisesNumber: Int
    let enterprises: [String]

    enum CodingKeys: String, CodingKey {
        case enterprisesNumber = "enterprises_number"
        case enterprises
    }
}
