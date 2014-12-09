//
//  tripDetailsViewController.m
//  drivetime
//
//  Created by Michael Gleissner on 8/10/10.
//  Copyright 2010 Harper College. All rights reserved.
//

#import "tripDetailsViewController.h"

@implementation tripDetailsViewController

@synthesize origin;
@synthesize dest;
@synthesize myOrigin;
@synthesize myDest;
//@synthesize driveTimeView;
//@synthesize dtController;

//http://maps.google.com/maps/api/directions/xml?origin=Chicago,IL&destination=Los+Angeles,CA&sensor=false



 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		NSLog(@"init ran");
		//origin.text = [[self parentViewController] startLoc];
    }
	//origin.text = myOrigin;
	//dest.text = myDest;
	NSLog(@"INIT %p", self); 
    return self;
}

- (void)viewDidAppear:(BOOL)animated
{
	//origin.text = [[self parentViewController] startLoc];
	//dest.text = [[self parentViewController] destLoc];
	NSLog(@"vDA %p", self);
	origin.text = myOrigin;
	dest.text = myDest;
	NSLog(@"vDA2 %p", self);
	//NSLog(@"viewdidappear");
}

- (BOOL)textFieldShouldReturn:(UITextField *)dest {
	[dest resignFirstResponder];
	return YES;
}

- (IBAction)getLoc:(id)sender
{
	NSString *curLoc = [[self parentViewController] myLoc];
	origin.text = curLoc;
	//[curLoc release];
	//NSLog(@"%@", curLoc);
}
						
						
						
- (IBAction)resignView:(id)sender
{
	[self writePlist:origin.text :dest.text]; 
	
	//[[self parentViewController] getPlaces:origin.text :dest.text];
	
	[self dismissModalViewControllerAnimated:YES];
}

- (void)writePlist:(NSString *)writeOrigin:(NSString *)writeDest
{
	//Get the doc path
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	//Define the plist location
	NSString *settingsPath =  [documentsDirectory stringByAppendingPathComponent:@"settings.plist"];
	
	//NSString *pathx = [[NSBundle mainBundle] bundlePath];
	//NSString *finalPath = [pathx stringByAppendingPathComponent:@"settings.plist"];
	NSMutableDictionary *plistDict = [[NSMutableDictionary dictionaryWithContentsOfFile:settingsPath] retain];
	
	
	//NSLog(@"%@", settingsPath);
	
	//NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:settingsPath];
	[plistDict setValue:writeOrigin forKey:@"startLoc"];
	[plistDict setValue:writeDest forKey:@"destLoc"];
	[plistDict writeToFile:settingsPath atomically: YES];
	[plistDict release];
	/* This would change the firmware version in the plist to 1.1.1 by initing the NSDictionary with the plist, then changing the value of the string in the key “ProductVersion” to what you specified */
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	//[responseData release];
	//[locationController release];

}


@end
