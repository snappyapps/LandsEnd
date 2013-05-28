//
//  ViewController.m
//  LandsEnd
//
//  Created by daren taylor on 26/05/2013.
//  Copyright (c) 2013 daren taylor. All rights reserved.
//

#import "ViewController.h"
#import "Place.h"
#import "SignTableViewCell.h"
#import "UIColor+LandsEndColor.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@property (nonatomic, strong) NSArray *places;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation ViewController {
  CLLocation *_lastLocation;
}

- (NSArray *)places
{
  if(_places == nil)
    _places = @[
                [Place name:@"Upper Tean" lat:52.9536 lng:-1.9874],
                [Place name:@"Miami" lat:25.7890 lng:-80.2264],
                [Place name:@"New York" lat:40.7144 lng:-74.0060],
                [Place name:@"London" lat:51.5112 lng:-0.1198],
                [Place name:@"Shanghai" lat:31.230393 lng:121.473704],
                [Place name:@"Istanbul" lat:41.005270 lng:28.976960],
                [Place name:@"Moscow" lat:55.751242 lng:37.618422]
                ];
    return _places;
}

- (NSArray *)filteredPlaces
{
  NSLog(@"%@", self.searchDisplayController.searchBar.text);
  
    return [_places filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name CONTAINS [cd] %@", self.searchDisplayController.searchBar.text]];
}

- (CLLocationManager *)locationManager
{
  if(_locationManager == nil) {
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
  }
  return _locationManager;
}

- (void)setupTableView:(UITableView *)tableView
{
  tableView.backgroundColor = [UIColor niceGreen];
  tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)awakeFromNib
{
  [self setupTableView:self.tableView];
  self.searchDisplayController.searchBar.tintColor = [UIColor niceGreen];
  self.navigationController.navigationBar.tintColor = [UIColor niceGreen];
  self.searchDisplayController.searchResultsDataSource = self;
  [self.locationManager startUpdatingLocation];
  
  CALayer *capa = [self.navigationController navigationBar].layer;
  CGRect bounds = capa.bounds;
  bounds.size.height += 10.0f;    //I'm reserving enough room for the shadow
  UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                                 byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                                       cornerRadii:CGSizeMake(10.0, 10.0)];
  
  CAShapeLayer *maskLayer = [CAShapeLayer layer];
  maskLayer.frame = bounds;
  maskLayer.path = maskPath.CGPath;
  [capa addSublayer:maskLayer];
  capa.mask = maskLayer;
}

#pragma mark - UISearchDisplayDelegate

- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView
{
  [self setupTableView:tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return (tableView == self.tableView ? self.places.count : [self filteredPlaces].count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  Place *place = (tableView == self.tableView ? self.places[indexPath.row] : [self filteredPlaces][indexPath.row]);
  
  SignTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"sign"];
  [cell setup];
  cell.placeLabel.text = place.name;
  cell.distanceLabel.text = [NSString stringWithFormat:@"%d", (NSInteger)[place distanceFromLocation:_lastLocation]];
  
  return cell;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
  _lastLocation = [locations lastObject];
  [self.tableView reloadData];
}

@end
