//
//  Models.swift
//  AirplanAston
//
//  Created by Андрей Цуркан on 07.09.2023.
//

import Foundation

struct UserData: Codable {
    var name: String
    var score: Int
    
}

extension String {
    static let airplaneArr = ["GrayAirplane", "GreenAirplane", "SpaceAirplane", "Airplane"]
}


