//
//  AlarmDefaults.swift
//  Exercise
//
//  Created by Nate Perry on 5/26/17.
//  Copyright © 2017 Ender Labs. All rights reserved.
//

import Foundation

struct AlarmDefaults {
    private static let alarmThresholdKey: String = "Defaults.AlarmThreshold"
    private static let alarmEnabledKey: String = "Defaults.AlarmEnabled"
    
    static var alarmThreshold: Float {
        get {
            guard let number = UserDefaults.standard.value(forKey: alarmThresholdKey) as? NSNumber else {
                return 0.9
            }
            return number.floatValue
        }
        set {
            let number = NSNumber(value: newValue)
            UserDefaults.standard.setValue(number, forKey: alarmThresholdKey)
        }
    }
    
    static var alarmEnabled: Bool {
        get {
            guard let number = UserDefaults.standard.value(forKey: alarmEnabledKey) as? NSNumber else {
                return true
            }
            return number.boolValue
        }
        set {
            let number = NSNumber(booleanLiteral: newValue)
            UserDefaults.standard.setValue(number, forKey: alarmEnabledKey)
        }
    }
}

