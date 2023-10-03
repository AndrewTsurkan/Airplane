//
//  UserSettings.swift
//  AirplanAston
//
//  Created by Андрей Цуркан on 08.09.2023.
//

import Foundation

final class UserSettings {
    
    private enum SettingsKeys: String {
        case userName
        case modelAirplane
        case modeGame
    }
    
    static var userName: String? {
        get {
            return UserDefaults.standard.string(forKey: SettingsKeys.userName.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = SettingsKeys.userName.rawValue
            if let newValue {
                defaults.set(newValue, forKey: key)
            }else {
                defaults.removeObject(forKey: key)
            }
        }
    }
    
    static var modelAirplane: Int? {
        get {
            return UserDefaults.standard.integer(forKey: SettingsKeys.modelAirplane.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let keyModelAirplane = SettingsKeys.modelAirplane.rawValue
            if let newValue {
                defaults.set(newValue, forKey: keyModelAirplane)
            }else {
                defaults.removeObject(forKey: keyModelAirplane)
            }
        }
    }
    
    static var modeGame: Int? {
        get {
            return UserDefaults.standard.integer(forKey: SettingsKeys.modeGame.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let keyModeGame = SettingsKeys.modeGame.rawValue
            if let newValue {
                defaults.set(newValue, forKey: keyModeGame)
            }else {
                defaults.removeObject(forKey: keyModeGame)
            }
        }
    }
}
