//
//  AJFourSquareSessionManager.h
//  World Traveler
//
//  Created by Allan Jones on 8/29/14.
//  Copyright (c) 2014 Allan Jones. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface AJFourSquareSessionManager : AFHTTPSessionManager

+(instancetype)sharedClient;

@end
