//
//  Contact.h
//  World Traveler
//
//  Created by Allan Jones on 9/2/14.
//  Copyright (c) 2014 Allan Jones. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AJRecord.h"

@class Venue;

@interface Contact : AJRecord

@property (nonatomic, retain) NSString * formattedPhone;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) Venue *venue;

@end
