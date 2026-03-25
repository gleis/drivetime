# DriveTime

DriveTime is a small early-iPhone app that looks up the estimated driving time between two locations and displays it on screen.

## What It Does

When the app opens, it:

1. Copies a default `settings.plist` into the app's Documents directory on first launch.
2. Reads the saved origin and destination from that plist.
3. Starts Core Location updates so the user can use their current coordinates as the trip origin.
4. Calls the Google Maps Directions XML endpoint with the saved origin and destination.
5. Parses the returned route duration and shows the human-readable drive time in the main view.

The app also includes a modal settings screen where the user can:

- Edit the origin and destination.
- Fill the origin field from the device's current latitude/longitude.
- Save those values back to `settings.plist`.

## How It Works

The codebase is a classic Objective-C UIKit app built around two view controllers:

- `Classes/drivetimeViewController.*`: main screen, plist loading, location startup, directions request, and duration display
- `tripDetailsViewController.*`: modal settings form for editing and persisting trip endpoints

Supporting pieces:

- `Classes/myLocation.*`: thin wrapper around `CLLocationManager`
- `TBXML.*`: XML parsing for the Google Directions response
- `settings.plist`: default origin/destination values bundled with the app

## Tech Stack

- Objective-C
- UIKit with XIB-based views
- Core Location
- Manual memory management
- Xcode project targeting the iOS 4.1 era SDK

## Important Caveats

This repository is best understood as a historical iOS sample/application snapshot.

- It uses the legacy `http://maps.google.com/maps/api/directions/xml` endpoint.
- That API format and access model have changed substantially since this code was written.
- The project uses older iOS APIs such as `presentModalViewController:` and `dismissModalViewControllerAnimated:`.
- The Xcode project is configured for the `iphoneos4.1` SDK, so opening it in a modern Xcode version will likely require migration work before it can build or run.

## Repository Layout

```text
.
├── Classes/
│   ├── drivetimeAppDelegate.*
│   ├── drivetimeViewController.*
│   └── myLocation.*
├── JSON/
├── TBXML.*
├── tripDetailsViewController.*
├── MainWindow.xib
├── drivetimeViewController.xib
├── tripDetailsViewController.xib
├── settings.plist
└── drivetime.xcodeproj
```

## Running It

If you want to inspect or modernize the app:

1. Open `drivetime.xcodeproj` in Xcode.
2. Allow Xcode to update project settings if prompted.
3. Replace the deprecated Google Directions integration with a current API.
4. Update deprecated UIKit and Core Location usage as needed.

## Summary

DriveTime is a simple iPhone app that stores two trip endpoints, optionally uses the phone's current location as the starting point, fetches route data from Google Maps, and displays the estimated driving duration.
