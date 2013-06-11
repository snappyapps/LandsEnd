//
//  CityTableViewCell.m
//  LandsEnd
//
//  Created by daren taylor on 26/05/2013.
//  Copyright (c) 2013 daren taylor. All rights reserved.
//

#import "CityTableViewCell.h"
#import "UIFont+LandsEndFont.h"
#import "UIColor+LandsEndColor.h"

@interface  CityTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@end

@implementation CityTableViewCell

- (void)setupAppearance
{
  self.cityLabel.font = [UIFont mainFont];
  self.distanceLabel.font = [UIFont mainFont];
  self.selectionStyle = UITableViewCellSelectionStyleNone;
  
  self.cityLabel.textColor = [UIColor textColor];
  self.distanceLabel.textColor = [UIColor textColor];
}

- (void)setCity:(City *)city location:(CLLocation *)location
{
  self.cityLabel.text = city.name;
  self.distanceLabel.text = [NSString stringWithFormat:@"%d", (NSInteger)[city distanceFromLocation:location]];
}

@end
