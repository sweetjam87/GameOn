//
//  ViewController.m
//  GameOn
//
//  Created by James McPherson on 2/6/15.
//  Copyright (c) 2015 James McPherson. All rights reserved.
//

#import "ViewController.h"
#import "LocationService.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [[LocationService sharedInstance]startUpdatingLocation];
    CLRegion* testRegion = [self createTestRegion];
    
    [[LocationService sharedInstance] startMonitoringRegion:testRegion];
    [[LocationService sharedInstance].locationManager requestStateForRegion:testRegion];
    
    // Add an observer for LocationService
    [[LocationService sharedInstance]addObserver:self forKeyPath:@"currentLocation" options:NSKeyValueObservingOptionNew context:nil];
    
}

-(CLRegion*)createTestRegion{
    
    CLLocationCoordinate2D testLatLong = CLLocationCoordinate2DMake(34.918293, -95.753624);
    CLLocationDistance radius = 100;
    CLCircularRegion* region = [[CLCircularRegion alloc]initWithCenter:testLatLong radius:radius identifier:@"home"];
    
    return region;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object  change:(NSDictionary *)change context:(void *)context
{
    CLLocation* location = [[LocationService sharedInstance]currentLocation];
    
    if([keyPath isEqualToString:@"currentLocation"]) {
        // Update Labels
        latitudeLabel.text = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
        longitudeLabel.text = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
        altitudeLabel.text = [NSString stringWithFormat:@"%f", location.altitude];
        hAccuracyLabel.text = [NSString stringWithFormat:@"%f", location.horizontalAccuracy];
        vAccuracyLabel.text = [NSString stringWithFormat:@"%f", location.verticalAccuracy];
        timestampLabel.text = [NSString stringWithFormat:@"%@", location.timestamp];
        speedLabel.text = [NSString stringWithFormat:@"%f", location.speed];
        courseLabel.text = [NSString stringWithFormat:@"%f", location.course];
        
        NSLog(@"Location Updated!");
    }
}

-(void)viewWillAppear:(BOOL)animated{
    //if ([CLLocationManager locationServicesEnabled]) {
        // Find Current Location
    //}
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
