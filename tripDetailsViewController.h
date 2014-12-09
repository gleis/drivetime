//
//  tripDetailsViewController.h
//  drivetime
//
//  Created by Michael Gleissner on 8/10/10.
//  Copyright 2010 Harper College. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myLocation.h"


@interface tripDetailsViewController : UIViewController <UITextFieldDelegate>{

	NSMutableData *responseData;
	myLocation *locationController;
	NSString *myOrigin;
	NSString *myDest;
	IBOutlet UITextField *origin;
	IBOutlet UITextField *dest;
	//drivetimeViewController *driveTimeView;
	//drivetimeViewController *dtController;
	
}

- (IBAction)getLoc:(id)sender;
- (IBAction)resignView:(id)sender;
- (void)writePlist:(NSString *)writeOrigin:(NSString *)writeDest;
@property (nonatomic, retain) IBOutlet UITextField *origin;
@property (nonatomic, retain) IBOutlet UITextField *dest;
@property (nonatomic, retain) NSString *myOrigin;
@property (nonatomic, retain) NSString *myDest;
//@property (nonatomic, retain) drivetimeViewController *driveTimeView;
//@property (nonatomic, retain) drivetimeViewController *dtController;

@end
