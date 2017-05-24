//
//  MapTypeViewController.h
//  Code_Library
//
//  Created by RIGEL on 3/17/17.
//  Copyright © 2017 RIGEL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapTypeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *typeSegment;
@property (weak, nonatomic) IBOutlet UIView *TypeMapView;

-(IBAction)mapTypeSegmentValueChange:(UISegmentedControl *)sender;
@end
