//
//  SettingsViewController.m
//  Exercise
//
//  Created by Donald Hays on 2/24/15.
//  Copyright (c) 2015 Ender Labs. All rights reserved.
//

#import "SettingsViewController.h"


@interface SettingsViewController()
@property (nonatomic, weak) IBOutlet UISlider *alarmThresholdSlider;
@property (nonatomic, weak) IBOutlet UISwitch *alarmEnabledSwitch;
@end

@implementation SettingsViewController
#pragma mark -
#pragma mark Actions
- (IBAction)done:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)alarmThresholdSliderValueChanged:(UISlider *)sender
{
    [AlarmState setAlarmThreshold:sender.value];
}

- (IBAction)alarmEnabledSwitchValueChanged:(UISwitch *)sender
{
    [AlarmState setAlarmEnabled:sender.isOn];
}


-(void)viewDidLoad {
    [super viewDidLoad];
    [AlarmState addSubscriber:self];
}

-(void)updateWith:(AlarmState *)state {
    [_alarmThresholdSlider setValue:state.alarmThreshold];
    [_alarmEnabledSwitch setOn:state.alarmEnabled];
}
@end
