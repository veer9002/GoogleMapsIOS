//
//  SimpleMapViewController.m
//  Code_Library
//
//  Created by RIGEL on 3/17/17.
//  Copyright © 2017 RIGEL. All rights reserved.
//

#import "SimpleMapViewController.h"
@import GoogleMaps;

@interface SimpleMapViewController ()

@end

@implementation SimpleMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:22.3072
                                                            longitude:73.1880
                                                                 zoom:6];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = camera.target;
    marker.snippet = @"Simple Map";
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = mapView;
    
    self.view = mapView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
