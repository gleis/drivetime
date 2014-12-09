//
//  myLocation.m
//  drivetime
//
//  Created by Michael Gleissner on 9/6/10.
//  Copyright 2010 Harper College. All rights reserved.
//

#import "myLocation.h"


@implementation myLocation

@synthesize locationManager;
@synthesize delegate;

- (id) init {
    self = [super init];
    if (self != nil) {
        self.locationManager = [[[CLLocationManager alloc] init] autorelease];
        self.locationManager.delegate = self; // send loc updates to myself
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"Location: %@", [newLocation description]);
	[self.delegate locationUpdate:newLocation];
}

- (void)locationManager:(CLLocationManager *)manager
	   didFailWithError:(NSError *)error
{
	NSLog(@"Error: %@", [error description]);
	[self.delegate locationError:error];
}

- (void)dealloc {
    [self.locationManager release];
    [super dealloc];
}

@end
