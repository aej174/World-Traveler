//
//  Location.h
//  World Traveler
//
//  Created by Allan Jones on 8/22/14.
//  Copyright (c) 2014 Allan Jones. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AJRecord.h"

@interface Location : AJRecord

@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * cc;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * crossStreet;
@property (nonatomic, retain) NSNumber * lng;
@property (nonatomic, retain) NSNumber * lat;
@property (nonatomic, retain) NSString * postalCode;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSManagedObject *venue;

@end
