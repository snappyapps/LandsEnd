//
//  ViewController.m
//  LandsEnd
//
//  Created by daren taylor on 26/05/2013.
//  Copyright (c) 2013 daren taylor. All rights reserved.
//

#import "ViewController.h"
#import "City.h"
#import "CityTableViewCell.h"
#import "UIColor+LandsEndColor.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CLGeocoder.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <CLLocationManagerDelegate>
@property (nonatomic, strong) NSArray *cities;
@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation ViewController {
  CLLocation *_lastLocation;
}

- (NSArray *)cities
{
  if(_cities == nil) {
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    NSString* content = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cities" ofType:@"csv"]
                                                  encoding:NSUTF8StringEncoding
                                                     error:nil];
    NSArray *elementsArray = [content componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@";"]];
   
    NSInteger index = 0;
    do {
      [mutableArray addObject:[City name:elementsArray[index++] lat:[elementsArray[index++] doubleValue] lng:[elementsArray[index++] doubleValue]]];
    } while (index < elementsArray.count);
    
    _cities = [mutableArray copy];
  }
  
  return _cities;  
}

- (NSArray *)filteredCities
{
  return [_cities filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name CONTAINS [cd] %@", self.searchDisplayController.searchBar.text]];
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
  tableView.backgroundColor = [UIColor backgroundColor];
  tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)addStrokeAndRoundedCornersToLayer:(CALayer *)layer
{
  [layer setCornerRadius:15.0];
  [layer setMasksToBounds:YES];
  layer.opaque = NO;
  
  [layer setBorderColor:[UIColor whiteColor].CGColor];
  [layer setBorderWidth:5];
}

- (void)customiseViewAppearance
{
  [self addStrokeAndRoundedCornersToLayer:self.tableView.layer];
  [self addStrokeAndRoundedCornersToLayer:self.navigationController.navigationBar.layer];
}

- (void)awakeFromNib
{
  [self setupTableView:self.tableView];
  self.searchDisplayController.searchBar.tintColor = [UIColor backgroundColor];
  self.searchDisplayController.searchResultsDataSource = self;
  [self.locationManager startUpdatingLocation];
  
  [self customiseViewAppearance];
  
  [[UINavigationBar appearance] setBackgroundColor:[UIColor whiteColor]];
}

-(void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];

}

- (void)updateTitleWithCurrentLocation
{
  CLGeocoder *geocoder = [[CLGeocoder alloc] init];
  
  __weak UIViewController* weakSelf = self;
  [geocoder reverseGeocodeLocation:_lastLocation completionHandler:^(NSArray *placemarks, NSError *error) {
    if(!error && placemarks && placemarks.count > 0) {
      CLPlacemark *topResult = [placemarks objectAtIndex:0];
      weakSelf.title = topResult.locality;
    }
  }];
}

#pragma mark - UISearchDisplayDelegate

- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView
{
  [self setupTableView:tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return (tableView == self.tableView ? self.cities.count : [self filteredCities].count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  City *city = (tableView == self.tableView ? self.cities[indexPath.row] : [self filteredCities][indexPath.row]);
  
  CityTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cityCellIdentifier"];
  [cell setupAppearance];

  [cell setCity:city location:_lastLocation];
  
  return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
  cell.backgroundColor = indexPath.row %2 ? [UIColor backgroundColor] : [UIColor backgroundColorLight];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
  _lastLocation = [locations lastObject];
  [self.tableView reloadData];

  [self updateTitleWithCurrentLocation];
}

@end
