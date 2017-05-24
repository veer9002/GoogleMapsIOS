//
//  MapTypeViewController.m
//  Code_Library
//
//  Created by RIGEL on 3/17/17.
//  Copyright © 2017 RIGEL. All rights reserved.
//

#import "MapTypeViewController.h"
@import GoogleMaps;

@interface MapTypeViewController ()
{
    GMSMapView *mapView;
}
@end

@implementation MapTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:22.3072
                                                            longitude:73.1880
                                                                 zoom:2];
    mapView = [GMSMapView mapWithFrame:self.view.bounds camera:camera];

    mapView.myLocationEnabled = YES;
    mapView.settings.myLocationButton = YES;

    // Available map types: kGMSTypeNormal, kGMSTypeSatellite, kGMSTypeHybrid,
    // kGMSTypeTerrain, kGMSTypeNone
    
    // Set the mapType to Satellite
     mapView.mapType = kGMSTypeNormal;

    [self.view addSubview:mapView];
    [self.view sendSubviewToBack:mapView];
}


- (IBAction)mapTypeSegmentValueChange:(UISegmentedControl *)sender {
    
//    int selectedSegmentIndex = sender.selectedSegmentIndex;
    if (_typeSegment.selectedSegmentIndex == 0) {
        mapView.mapType = kGMSTypeNormal;
    }else if (_typeSegment.selectedSegmentIndex == 1) {
        mapView.mapType = kGMSTypeSatellite;
    } else if (_typeSegment.selectedSegmentIndex == 2) {
        mapView.mapType = kGMSTypeHybrid;
    } else if (_typeSegment.selectedSegmentIndex == 3) {
        mapView.mapType = kGMSTypeTerrain;
    }

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
