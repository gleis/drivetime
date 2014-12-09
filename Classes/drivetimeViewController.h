//
//  drivetimeViewController.h
//  drivetime
//
//  Created by Michael Gleissner on 8/5/10.
//  Copyright 2010 Harper College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tripDetailsViewController.h"
#import "myLocation.h"

@interface drivetimeViewController : UIViewController <myLocationDelegate> {
	NSMutableData *responseData;
	NSString *startLoc;
	NSString *destLoc;
	NSString *plistFile;
	NSString *setOrigin;
	NSString *setDest;
	NSString *myLoc;
	tripDetailsViewController *settingsController;
	tripDetailsViewController *setCont;
	myLocation *locationController;
	
	IBOutlet UILabel *dtimeLabel;
	IBOutlet UILabel *originLabel;
	IBOutlet UILabel *destLabel;
	IBOutlet UILabel *locationLabel;
	//IBAction UIButton *dtimeSettingsButton;
}

- (void)showSettings;
- (void)getPlaces:(NSString *)origin:(NSString *)dest;
- (void)driveDataConn:(NSString *)start:(NSString *)end;
- (void)readPlist;
- (IBAction)settingsClick:(id)sender;

- (void)locationUpdate:(CLLocation *)location;
- (void)locationError:(NSError *)error;

@property (nonatomic, retain) UILabel *dtimeLabel;
@property (nonatomic, retain) UILabel *originLabel;
@property (nonatomic, retain) UILabel *destLabel;
@property (nonatomic, retain) UIButton *dtimeSettingsButton;
@property (nonatomic, retain) tripDetailsViewController *setCont;
@property (nonatomic, retain) NSString *startLoc;
@property (nonatomic, retain) NSString *destLoc;
@property (nonatomic, retain) NSString *myLoc;

@end

