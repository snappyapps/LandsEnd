//
//  Place.m
//  LandsEnd
//
//  Created by daren taylor on 26/05/2013.
//  Copyright (c) 2013 daren taylor. All rights reserved.
//

#import "City.h"

@implementation City

+ (id)name:(NSString *)name lat:(CLLocationDegrees)lat lng:(CLLocationDegrees)lng
{
  City *place = [[City alloc] init];
  place.name = name;
  place.location = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
  
  return place;
}

- (CLLocationDistance)distanceFromLocation:(CLLocation *)location;
{
  return [self.location distanceFromLocation:location]/1608;
}

@end
