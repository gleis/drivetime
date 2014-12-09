//
//  myLocation.h
//  drivetime
//
//  Created by Michael Gleissner on 9/6/10.
//  Copyright 2010 Harper College. All rights reserved.
//

@protocol myLocationDelegate 
@required
- (void)locationUpdate:(CLLocation *)location;
- (void)locationError:(NSError *)error;
@end

#import <Foundation/Foundation.h>


@interface myLocation : NSObject <CLLocationManagerDelegate> {
	CLLocationManager *locationManager;
	id delegate;
}

@property (nonatomic, retain) CLLocationManager *locationManager;  
@property (nonatomic, assign) id  delegate;

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation;

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error;


@end
