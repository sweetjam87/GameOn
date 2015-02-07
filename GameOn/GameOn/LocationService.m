//
//  LocationService.m
//  GameOn
//
//  Created by James McPherson on 2/6/15.
//  Copyright (c) 2015 James McPherson. All rights reserved.
//

#import "LocationService.h"
#import <CoreLocation/CoreLocation.h>
#import "ViewController.h"

@implementation LocationService

+(LocationService*)sharedInstance{
    
    static LocationService *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

-(id)init{
    self = [super init];
    
    if (self != nil) {
        self.locationManager = [[CLLocationManager alloc]init];
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter = 1; // Meters
        self.locationManager.delegate = self;
        [self.locationManager requestAlwaysAuthorization];
    }
    
    return self;
}

-(void)startUpdatingLocation{
    // Begin Location Updates
    [self.locationManager startUpdatingLocation];
    
}

-(void)stopUpdatingLocation{
    // Stop Location Updates
    [self.locationManager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"Service Failed With Error: %@", error);
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation* location = locations.lastObject;
    self.currentLocation = location;
}

@end
