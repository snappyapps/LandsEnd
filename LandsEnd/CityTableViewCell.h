//
//  CityTableViewCell.h
//  LandsEnd
//
//  Created by daren taylor on 26/05/2013.
//  Copyright (c) 2013 daren taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"

@interface CityTableViewCell : UITableViewCell

- (void)setCity:(City *)city location:(CLLocation *)location;
- (void)setupAppearance;

@end
