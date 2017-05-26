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
}

//////////////////////////////
// MARK: - Set Values
extension AlarmState {
    private static func restrictToUnitSegment(_ value: Float) -> Float {
        return min(max(value, 0), 1)
    }
    
    static func setDangerLevel(_ level: Float) {
        let level = restrictToUnitSegment(level)
        currentState.dangerLevel = level
        update()
    }
    
    static func setAlarmThreshold(_ threshold: Float) {
        let threshold = restrictToUnitSegment(threshold)
        currentState.alarmThreshold = threshold
        AlarmDefaults.alarmThreshold = threshold
        update()
    }
    
    static func setAlarmEnabled(_ enabled: Bool) {
        currentState.alarmEnabled = enabled
        AlarmDefaults.alarmEnabled = enabled
        update()
    }
}

//////////////////////////////
// MARK: - Manage Subscriptions
extension AlarmState {
    static func addSubscriber(_ subscriber: AlarmSubscriber) {
        wrappers = wrappers.filter({ $0.subscriber != nil })
        subscriber.update(with: currentState)
        let wrapper = SubscriberWrapper(subscriber: subscriber)
        wrappers.append(wrapper)
    }
}

//////////////////////////////
// MARK: - Updating
extension AlarmState {
    static var shouldAlarmBeActive: Bool {
        guard currentState.alarmEnabled else {
            return false
        }
        return currentState.dangerLevel >= currentState.alarmThreshold
    }
    
    fileprivate static func update() {
        updateSubscribers()
        manageAlarm()
    }
    
    private static func updateSubscribers() {
        DispatchQueue.main.async {
            for wrapper in wrappers {
                wrapper.subscriber?.update(with: currentState)
            }
        }
    }
    
    private static func manageAlarm() {
        guard isAlarmActive() != shouldAlarmBeActive else {
            return
        }
        if shouldAlarmBeActive {
            activateAlarm()
        } else {
            deactivateAlarm()
        }
    }
}



