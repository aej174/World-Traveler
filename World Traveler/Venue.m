//
//  Venue.m
//  World Traveler
//
//  Created by Allan Jones on 8/22/14.
//  Copyright (c) 2014 Allan Jones. All rights reserved.
//

#import "Venue.h"
#import "Menu.h"
#import "FSCategory.h"
#import "Contact.h"
#import "Location.h"

@implementation Venue

@dynamic name;
@dynamic id;
@dynamic contact;
@dynamic favorite;
@dynamic categories;
@dynamic location;
@dynamic menu;

+(NSString *)keypathForResponseObject
{
    return @"response.venues";
}

@end
