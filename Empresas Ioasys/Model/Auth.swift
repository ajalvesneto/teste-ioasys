//
//  Auth.swift
//  Empresas Ioasys
//
//  Created by Antonio Alves on 10/04/21.
//

import Foundation



extension UserDefaults {
    func auth(forKey defaultName: String) -> Auth? {
        guard let data = data(forKey: defaultName) else { return nil }
        do {
            return try JSONDecoder().decode(Auth.self, from: data)
        } catch { print(error); return nil }
    }

    func set(_ value: Auth, forKey defaultName: String) {
        let data = try? JSONEncoder().encode(value)
        set(data, forKey: defaultName)
    }
}
