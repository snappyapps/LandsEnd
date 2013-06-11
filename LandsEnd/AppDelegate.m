//
//  AppDelegate.m
//  LandsEnd
//
//  Created by daren taylor on 26/05/2013.
//  Copyright (c) 2013 daren taylor. All rights reserved.
//

#import "AppDelegate.h"
#import "UIFont+LandsEndFont.h"

@implementation AppDelegate

- (void)customiseSearchBar
{
[[UISearchBar appearance] setBackgroundImage:[UIImage imageNamed:@"navbarback"]];
[[UINavigationBar appearance] setBackgroundImage:[[UIImage imageNamed:@"navbarback"] resizableImageWithCapInsets:UIEdgeInsetsZero resizingMode:UIImageResizingModeTile] forBarMetrics:UIBarMetricsDefault];
}

- (void)customiseNavigationBar
{
  [[UINavigationBar appearance] setTitleTextAttributes:
 [NSDictionary dictionaryWithObjectsAndKeys:
  [UIColor whiteColor],
  UITextAttributeTextColor,
  [UIFont navigationBarFont],
  UITextAttributeFont,
  nil]];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
  [self customiseSearchBar];
  [self customiseNavigationBar];
  
  return YES;
}

@end
