//
//  SignTableViewCell.h
//  LandsEnd
//
//  Created by daren taylor on 26/05/2013.
//  Copyright (c) 2013 daren taylor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *placeLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

- (void)setup;
@end
