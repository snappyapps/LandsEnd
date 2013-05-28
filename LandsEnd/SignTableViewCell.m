//
//  SignTableViewCell.m
//  LandsEnd
//
//  Created by daren taylor on 26/05/2013.
//  Copyright (c) 2013 daren taylor. All rights reserved.
//

#import "SignTableViewCell.h"

@implementation SignTableViewCell

- (void)setup
{
  UIFont *font = [UIFont fontWithFamilyName:@"Transport" size:20.0];
  
  self.placeLabel.font = font;
  
  NSLog(@"%@",  [UIFont familyNames]);
}

@end
