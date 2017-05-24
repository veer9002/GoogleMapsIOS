//
//  CustomMarkerViewController.m
//  Code_Library
//
//  Created by RIGEL on 3/17/17.
//  Copyright © 2017 RIGEL. All rights reserved.
//

#import "CustomMarkerViewController.h"
@import GoogleMaps;

@interface CustomMarkerViewController ()

@end

@implementation CustomMarkerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:22.3072
                                                            longitude:73.1880
                                                                 zoom:15];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    mapView.settings.myLocationButton = YES;
    
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(22.3072,73.1880);
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.icon = [UIImage imageNamed:@"flag_icon"];
    marker.map = mapView;
    
    GMSMarker *marker2 = [[GMSMarker alloc]init];
    marker2.position = CLLocationCoordinate2DMake(22.3072, 73.1818);
    marker2.icon = [GMSMarker markerImageWithColor:[UIColor greenColor]];
    marker2.map = mapView;
    
    GMSMarker *marker3 = [[GMSMarker alloc] init];
    marker3.position = CLLocationCoordinate2DMake(22.3107232, 73.1810142);
    marker3.icon = [GMSMarker markerImageWithColor:[UIColor purpleColor]];
    marker3.map = mapView;

    
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
