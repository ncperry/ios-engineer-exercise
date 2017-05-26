//
//  DangerViewController.m
//  Exercise
//
//  Created by Donald Hays on 2/24/15.
//  Copyright (c) 2015 Ender Labs. All rights reserved.
//

#import "DangerViewController.h"

@interface DangerViewController()
@property (nonatomic, weak) IBOutlet UISlider *dangerSlider;
@end

@implementation DangerViewController
#pragma mark -
#pragma mark Actions
- (IBAction)dangerSliderValueChanged:(UISlider *)sender
{
    [AlarmState setDangerLevel:sender.value];
}

-(void)updateWith:(AlarmState *)state {
    [_dangerSlider setValue:state.dangerLevel];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [AlarmState addSubscriber:self];
}

@end
