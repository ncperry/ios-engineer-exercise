//
//  AppForegroundState.swift
//  Exercise
//
//  Created by Nate Perry on 5/26/17.
//  Copyright © 2017 Ender Labs. All rights reserved.
//

import Foundation
import UIKit

private let observerWriteMutex = NSLock()
private var foregroundStateObserver: AppForegroundState? = nil

class AppForegroundState: NSObject {
    static var isInForeground: Bool {
        switch UIApplication.shared.applicationState {
        case .active:
            return true
        case .inactive, .background:
            return false
        }
    }
    
    static func observeAppStatus() {
        observerWriteMutex.lock()
        defer {
            observerWriteMutex.unlock()
        }
        
        guard foregroundStateObserver == nil else {
            return
        }
        
        let observer = AppForegroundState()
        NotificationCenter.default.addObserver(observer, selector: #selector(enterForeground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        NotificationCenter.default.addObserver(observer, selector: #selector(leaveForeground), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        foregroundStateObserver = observer
    }
    
    @objc private func enterForeground() {
        AlarmState.setAppIn(true)
    }
    
    @objc private func leaveForeground() {
        AlarmState.setAppIn(false)
    }
}

