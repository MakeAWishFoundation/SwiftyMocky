//
//  MockySetup.m
//  SwiftyMocky
//
//  Created by Andrzej Michnia on 30.09.2018.
//  Copyright © 2018 MakeAWishFoundation. All rights reserved.
//

#import "MockySetup.h"
#import <SwiftyMocky/SwiftyMocky-Swift.h>

@implementation MockySetup

+ (void)load
{
    [SwiftyMockyTestObserver setup];
}

+ (void)setup
{
    [SwiftyMockyTestObserver setup];
}

@end
