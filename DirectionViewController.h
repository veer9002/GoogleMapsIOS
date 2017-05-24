//
//  DirectionViewController.h
//  Code_Library
//
//  Created by RIGEL on 3/29/17.
//  Copyright © 2017 RIGEL. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMaps;
#import <MapKit/MapKit.h>
#import <GooglePlaces/GooglePlaces.h>
#import "BaseURL+APIKey.m"

@interface DirectionViewController : UIViewController <GMSMapViewDelegate,MKMapViewDelegate,GMSAutocompleteViewControllerDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtStartLocation;
@property (weak, nonatomic) IBOutlet UITextField *txtDestination;
- (IBAction)btnShowDirections:(id)sender;

@end
