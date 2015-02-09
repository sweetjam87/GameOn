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

-(void)startMonitoringRegion:(CLRegion*)region{
    [self.locationManager startMonitoringForRegion:region];
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

//-(void)locationManager:(CLLocationManager *)manager didStartMonitoringForRegion:(CLRegion *)region{
//    
//}

-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    UILocalNotification* notification = [[UILocalNotification alloc]init];
    notification.fireDate = [NSDate date];
    notification.alertBody = @"You Are Here!";
    notification.timeZone = [NSTimeZone defaultTimeZone];
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
        UILocalNotification* notification = [[UILocalNotification alloc]init];
        notification.fireDate = [NSDate date];
        notification.alertBody = @"You Have Left Home";
        notification.timeZone = [NSTimeZone defaultTimeZone];
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

-(void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region{
    if (state == CLRegionStateInside) {
        UILocalNotification* notification = [[UILocalNotification alloc]init];
        notification.fireDate = [NSDate date];
        notification.alertBody = @"You Are At Home!";
        notification.timeZone = [NSTimeZone defaultTimeZone];
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
}

-(void)locationManager:(CLLocationManager *)manager rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error{
    NSLog(@"Monitoring Region failed with error: %@", error);
}



@end
