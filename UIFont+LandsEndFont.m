//
//  UIFont+LandsEndFont.m
//  LandsEnd
//
//  Created by daren taylor on 30/05/2013.
//  Copyright (c) 2013 daren taylor. All rights reserved.
//

#import "UIFont+LandsEndFont.h"

@implementation UIFont (LandsEndFont)

+ (UIFont*)mainFont
{
  if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
    return [UIFont fontWithName:@"Transport" size:24.0];
  }
  return [UIFont fontWithName:@"Transport" size:40.0];
}

+ (UIFont*)navigationBarFont
{
  if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
    return [UIFont fontWithName:@"Transport" size:22.0];
  }
  return [UIFont fontWithName:@"Transport" size:23.0];
}

@end
