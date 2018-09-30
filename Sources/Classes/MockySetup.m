//
//  MockySetup.m
//  SwiftyMocky
//
//  Created by Andrzej Michnia on 30.09.2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

#import "MockySetup.h"
#import <SwiftyMocky/SwiftyMocky-Swift.h>

@implementation MockySetup

+ (void)load
{
    NSLog(@"LOADED SWIFTY MOCKY - HELLO :)");
    [SwiftyMockyTestObserver setup];
}

+ (void)setup
{
    NSLog(@"SWIFTY MOCK - SETUP OBSERVERS");
    [SwiftyMockyTestObserver setup];
}

@end
