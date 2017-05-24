//
//  SearchPlaceViewController.h
//  Code_Library
//
//  Created by RIGEL on 3/27/17.
//  Copyright © 2017 RIGEL. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMaps;
@import GooglePlaces;
#import "BaseURL+APIKey.m"
#import <CoreLocation/CoreLocation.h>

@interface SearchPlaceViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *txtSearchPlaces;
- (IBAction)btnShow:(id)sender;


@end
