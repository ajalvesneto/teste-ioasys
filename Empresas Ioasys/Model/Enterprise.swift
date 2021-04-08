//
//  Enterprises.swift
//  Empresas Ioasys
//
//  Created by Antonio Alves on 06/04/21.
//
import Foundation

struct EnterpriseResponse<T: Decodable>: Decodable {
    var enterprises: [Enterprise]
    var errors: [String]?
}

struct Enterprise: Codable {
    let id: Int
    let emailEnterprise, facebook, twitter, linkedin: String?
    let phone: String?
    let ownEnterprise: Bool
    let enterpriseName: String
    let photo: String?
    let enterprisDescription, city, country: String
    let value, sharePrice: Int
    let enterpriseType: EnterpriseType

    enum CodingKeys: String, CodingKey {
        case id
        case emailEnterprise = "email_enterprise"
        case facebook, twitter, linkedin, phone
        case ownEnterprise = "own_enterprise"
        case enterpriseName = "enterprise_name"
        case photo
        case enterprisDescription = "description"
        case city, country, value
        case sharePrice = "share_price"
        case enterpriseType = "enterprise_type"
    }
}

struct EnterpriseType: Codable {
    let id: Int
    let enterpriseTypeName: String

    enum CodingKeys: String, CodingKey {
        case id
        case enterpriseTypeName = "enterprise_type_name"
    }
}
