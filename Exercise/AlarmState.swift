//
//  AlarmState.swift
//  Exercise
//
//  Created by Nate Perry on 5/26/17.
//  Copyright © 2017 Ender Labs. All rights reserved.
//

import Foundation

private struct SubscriberWrapper {
    weak var subscriber: AlarmSubscriber?
}

private var wrappers = [SubscriberWrapper]()

private var currentState = AlarmState()

class AlarmState: NSObject {
    var dangerLevel: Float
    var alarmThreshold: Float
    var alarmEnabled: Bool
    
    override init() {
        dangerLevel = 0.5
        alarmThreshold = AlarmDefaults.alarmThreshold
        alarmEnabled = AlarmDefaults.alarmEnabled
    }
    
    static func setDangerLevel(_ level: Float) {
        currentState.dangerLevel = level
        updateSubscribers()
    }
    
    static func setAlarmThreshold(_ threshold: Float) {
        currentState.alarmThreshold = threshold
        updateSubscribers()
    }
    
    static func setAlarmEnabled(_ enabled: Bool) {
        currentState.alarmEnabled = enabled
        updateSubscribers()
    }
    
    static func addSubscriber(_ subscriber: AlarmSubscriber) {
        subscriber.update(with: currentState)
        let wrapper = SubscriberWrapper(subscriber: subscriber)
        wrappers.append(wrapper)
    }
    
    private static func updateSubscribers() {
        DispatchQueue.main.async {
            for wrapper in wrappers {
                wrapper.subscriber?.update(with: currentState)
            }
        }
    }
}



