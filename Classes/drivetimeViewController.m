//
//  drivetimeViewController.m
//  drivetime
//
//  Created by Michael Gleissner on 8/5/10.
//  Copyright 2010 Harper College. All rights reserved.
//

#import "drivetimeViewController.h"
#import "JSON.h"
#import "TBXML.h"


@implementation drivetimeViewController

@synthesize dtimeLabel;
@synthesize originLabel;
@synthesize destLabel;
@synthesize setCont;
@synthesize startLoc;
@synthesize destLoc;
@synthesize myLoc;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
	
	}

- (void)viewDidAppear:(BOOL)animated
{
	
	locationController = [[myLocation alloc] init];
	locationController.delegate = self;
    [locationController.locationManager startUpdatingLocation];
	
	NSLog(@"viewDidAppear");
	
	//originLabel.text = @"Loading...";
	//destLabel.text = @"Loading...";
	//dtimeLabel.text = @"Loading...";
	NSLog(@"viewDidAppearX");
	//Get the doc path
	//NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	//NSString *documentsDirectory = [paths objectAtIndex:0];
	
	//Define the plist location
	//NSString *settingsPath =  [documentsDirectory stringByAppendingPathComponent:@"settings.plist"];
	
	//Check if the plist exists
	//NSString plistPath = 
	//BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:settingsPath];
	NSLog(@"viewDidAppear2");
	[self readPlist];
	NSLog(@"viewDidAppear3");
	originLabel.text = startLoc;
	destLabel.text = destLoc;
	NSLog(@"viewDidAppear4");
	//if (fileExists) {
	//	NSLog(@"plist here");
		//read it
	//} else {
	//	NSLog(@"plist missing");
		
		//self.showSettings;		
	//}
	
	//startLoc = @"Chicago,IL";
	//destLoc = @"Daytona,FL";
	
	NSLog(@"viewDidAppear5");
	[self driveDataConn:startLoc :destLoc];
	
}

- (void)driveDataConn:(NSString *)start:(NSString *)end
{
	
	NSLog(@"driveDataConn running");
	NSString *startClean = [start stringByReplacingOccurrencesOfString:@" " withString:@"+"];
	NSString *endClean = [end stringByReplacingOccurrencesOfString:@" " withString:@"+"];
	
	NSString *urlStart = @"http://maps.google.com/maps/api/directions/xml?origin=";
	NSString *urlMid = [urlStart stringByAppendingFormat:@"%@", startClean];
	NSString *urlMid2 = [urlMid stringByAppendingString:@"&destination="];
	NSString *urlMid3 = [urlMid2 stringByAppendingFormat:@"%@", endClean];
	NSString *url = [urlMid3 stringByAppendingString:@"&sensor=false"];
	
	NSLog(@"%@", url);
	
	//responseData = [[NSMutableData data] retain];
	//NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://maps.google.com/maps/api/directions/json?origin=Chicago,IL&destination=Los+Angeles,CA&sensor=false"]];
	
	//TBXML *request = [[TBXML tbxmlWithURL:[NSURL URLWithString:@"http://maps.google.com/maps/api/directions/xml?origin=Chicago,IL&destination=Iowa+City,IA&sensor=false"]] retain];
	
	NSLog(@"Before TBXML");
	TBXML *request = [[TBXML tbxmlWithURL:[NSURL URLWithString:url]] retain];
	
	TBXMLElement *root = request.rootXMLElement;
	TBXMLElement *route = [TBXML childElementNamed:@"route" parentElement:root];
	TBXMLElement *leg = [TBXML childElementNamed:@"leg" parentElement:route];
	TBXMLElement *dura = [TBXML childElementNamed:@"duration" parentElement:leg];
	TBXMLElement *text = [TBXML	childElementNamed:@"text" parentElement:dura];
	
	NSLog(@"After TBXML");
	NSString *textline = [TBXML textForElement:text];
	
	dtimeLabel.text = textline;
	
	//[TBXML release];
	
	
	NSLog(@"%@", textline);
	
	
	NSString *gDays = nil;
	NSString *gHours = nil;
	NSString *gMinutes = nil;
	
	NSScanner *scanner = [NSScanner scannerWithString:textline];
	BOOL *scangood = [scanner scanUpToString:@"days" intoString:&gDays];
	if (scangood)
	{
		NSLog(@"day string exists");
	}
	//[scanner scanUpToString:@"hours" intoString:&gHours];
	//[scanner scanUpToString:@"minutes" intoString:&gMinutes];
	
	//NSLog(@"%@", gHours);
	
	
	
	
	//NSLog(@"%@", bob);
	
	
	
	//[[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)showSettings
{	
	settingsController = [[tripDetailsViewController alloc]
						  initWithNibName:@"tripDetailsViewController" bundle:nil];
	self.setCont = settingsController;
	//settingsController.delegate = self;
	//[setCont setDelegate:self];
	setCont.myOrigin = startLoc;
	setCont.myDest = destLoc;
	[self presentModalViewController:self.setCont animated:YES];
}	

- (void)getPlaces:(NSString *)origin:(NSString *)dest
{
	NSLog(@"%@  %@", origin, dest);
	self.startLoc = origin;
	self.destLoc = dest; 
	NSLog(@"end of getPlaces");
	//[drivetimeViewController driveDataConn:origin :dest];
}
	

- (IBAction)settingsClick:(id)sender;
{
	self.showSettings;
}

- (void)readPlist
{
	//NSString *filePath = path;
	
	//NSString *pathx = [[NSBundle mainBundle] bundlePath];
	//NSString *finalPath = [pathx stringByAppendingPathComponent:@"settings.plist"];
	//NSDictionary *plistDictionary = [[NSDictionary dictionaryWithContentsOfFile:finalPath] retain];
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];
	
	//Define the plist location
	NSString *settingsPath =  [documentsDirectory stringByAppendingPathComponent:@"settings.plist"];
	NSDictionary *plistDictionary = [[NSDictionary dictionaryWithContentsOfFile:settingsPath] retain];
	
	//NSLog(@"plist path %@", path);
	//NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
	startLoc = [plistDictionary objectForKey:@"startLoc"];
	destLoc = [plistDictionary objectForKey:@"destLoc"];
	NSLog(@"plist says: %@ %@", startLoc, destLoc);
	[plistDictionary release];
	/* You could now call the string “value” from somewhere to return the value of the string in the .plist specified, for the specified key. */
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	//label.text = [NSString stringWithFormat:@"Connection failed: %@", [error description]];
	UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:@"I'm sorry Dave, I'm afraid I can't do that." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
    [alert setTag:12];
    [alert show];
}


- (void)locationUpdate:(CLLocation *)location {
    NSString *lat = [NSString stringWithFormat:@"%f", location.coordinate.latitude];
	NSString *lon = [NSString stringWithFormat:@"%f", location.coordinate.longitude];
	myLoc = [NSString stringWithFormat:@"%@, %@", lat, lon];
	locationLabel.text = myLoc;
	//[myLoc release];
	
}

- (void)locationError:(NSError *)error {
    //locationLabel.text = [error description];
}


//- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	//[connection release];
	
	
	
	
	//NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	//[responseData release];
	
	//NSLog(@"%@", responseString);
	
	// creating new parser  
    //SBJsonParser *jParse = [[SBJsonParser new] autorelease]; 
	//NSError *jsonError;
	//NSDictionary *parsedJSON = [jParse objectWithString:responseString error:&jsonError];
	//NSDictionary *parsedJSON = [responseString JSONValue];
	//NSLog(@"fisrt Dict");
	//NSArray *gGo = [[[[parsedJSON objectForKey:@"routes"] objectForKey:@"legs"] objectForKey:@"duration"];
	
	//NSString *olo = [gGo objectAtIndex:0];
	//NSLog(@"second Dict");
	//NSDictionary* gTime = [parsedJSON objectForKey:@"routes"];
	//NSDictionary* gLeg = [gTime objectForKey:@"legs"];
	//NSDictionary* gDura = [gLeg objectForKey:@"duration"];
	//NSLog(@"Menu id: %@", [gGo objectForKey:@"text"]);
	//NSLog(@"Menu value: %@", [gTime objectForKey:@"summary"]);
	//NSLog(@"%@", gGo);
	
	//NSArray *driveData = [responseString JSONValue];
	
	/*NSMutableString *text = [NSMutableString stringWithString:@"Data:\n"];
	
	for (int i = 0; i < [driveData count]; i++)
		[text appendFormat:@"%@\n", [driveData objectAtIndex:i]];
	
	NSLog(@"%@", text);*/
	//label.text =  text;
//}



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


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
	NSLog(@"MEMORY WARNING");
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
	//[responseData release];
	//[startLoc release];
	//[destLoc release];
	//[plistFile release];
	//[setOrigin release];
	//[setDest release];
	//[myLoc release];
	
}

@end
