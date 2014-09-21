//
//  FSCategory.h
//  World Traveler
//
//  Created by Allan Jones on 9/2/14.
//  Copyright (c) 2014 Allan Jones. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AJRecord.h"

@class Venue;

@interface FSCategory : AJRecord

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Venue *venue;

@end
