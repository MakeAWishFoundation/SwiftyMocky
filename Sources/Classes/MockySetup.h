//
//  MockySetup.h
//  SwiftyMocky
//
//  Created by Andrzej Michnia on 30.09.2018.
//  Copyright © 2018 MakeAWishFoundation. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

@interface MockySetup : NSObject

/**
 [Internal] Call to setup mocky observers. There should be no need to call it directly.
 */
+ (void) setup;

@end

NS_ASSUME_NONNULL_END
