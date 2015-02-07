//
//  ViewController.h
//  GameOn
//
//  Created by James McPherson on 2/6/15.
//  Copyright (c) 2015 James McPherson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController
{
//    CLLocationManager* locationManager;
//    CLLocation* location;
    
    IBOutlet UILabel* latitudeLabel;
    IBOutlet UILabel* longitudeLabel;
    IBOutlet UILabel* altitudeLabel;
    IBOutlet UILabel* hAccuracyLabel;
    IBOutlet UILabel* vAccuracyLabel;
    IBOutlet UILabel* timestampLabel;
    IBOutlet UILabel* speedLabel;
    IBOutlet UILabel* courseLabel;
    
    
}

@end

