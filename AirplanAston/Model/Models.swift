//
//  Models.swift
//  AirplanAston
//
//  Created by Андрей Цуркан on 07.09.2023.
//

import Foundation

struct UserData: Codable {
    var name: String
    var score: Int = 0 
}

extension String {
    static let airplaneArr = ["GrayAirplane", "GreenAirplane", "SpaceAirplane", "Airplane"]
}


