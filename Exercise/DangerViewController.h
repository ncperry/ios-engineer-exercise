//
//  DangerViewController.h
//  Exercise
//
//  Created by Donald Hays on 2/24/15.
//  Copyright (c) 2015 Ender Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Exercise-Swift.h"

/// A DangerViewController allows the user to control the danger level, which
/// may activate or deactivate the alarm. You should not instantiate instances
/// of this class directly.
@interface DangerViewController : UIViewController <AlarmSubscriber>
@end
