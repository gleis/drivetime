//
//  drivetimeAppDelegate.h
//  drivetime
//
//  Created by Michael Gleissner on 8/5/10.
//  Copyright 2010 Harper College. All rights reserved.
//

#import <UIKit/UIKit.h>

@class drivetimeViewController;

@interface drivetimeAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    drivetimeViewController *viewController;
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet drivetimeViewController *viewController;

@end

