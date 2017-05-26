//
//  AlarmSubscriber.swift
//  Exercise
//
//  Created by Nate Perry on 5/26/17.
//  Copyright © 2017 Ender Labs. All rights reserved.
//

import Foundation

@objc protocol AlarmSubscriber: class {
    @objc func update(with state: AlarmState)
}



