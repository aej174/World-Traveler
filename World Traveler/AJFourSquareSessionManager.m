//
//  AJFourSquareSessionManager.m
//  World Traveler
//
//  Created by Allan Jones on 8/29/14.
//  Copyright (c) 2014 Allan Jones. All rights reserved.
//

#import "AJFourSquareSessionManager.h"

static NSString *const AJFoursquareBaseURLString = @"https://api.foursquare.com/v2/";

@implementation AJFourSquareSessionManager

+(instancetype)sharedClient
{
    static AJFourSquareSessionManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[AJFourSquareSessionManager alloc] initWithBaseURL:[NSURL URLWithString:AJFoursquareBaseURLString]];
    });
    return _sharedClient;
}

@end
