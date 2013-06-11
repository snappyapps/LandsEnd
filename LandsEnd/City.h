//
//  Place.h
//  LandsEnd
//
//  Created by daren taylor on 26/05/2013.
//  Copyright (c) 2013 daren taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface City : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) CLLocation *location;

+ (id)name:(NSString *)name lat:(CLLocationDegrees)lat lng:(CLLocationDegrees)lng;
- (CLLocationDistance)distanceFromLocation:(CLLocation *)location;

@end
