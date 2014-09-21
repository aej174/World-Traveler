//
//  Venue.h
//  World Traveler
//
//  Created by Allan Jones on 9/2/14.
//  Copyright (c) 2014 Allan Jones. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AJRecord.h"

@class Contact, FSCategory, Location, Menu;

@interface Venue : AJRecord

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * favorite;
@property (nonatomic, retain) FSCategory *categories;
@property (nonatomic, retain) Contact *contact;
@property (nonatomic, retain) Location *location;
@property (nonatomic, retain) Menu *menu;

@end
