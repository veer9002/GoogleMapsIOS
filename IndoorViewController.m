//
//  IndoorViewController.m
//  Code_Library
//
//  Created by RIGEL on 3/17/17.
//  Copyright © 2017 RIGEL. All rights reserved.
//

#import "IndoorViewController.h"
@import GoogleMaps;

@interface IndoorViewController ()

@end

@implementation IndoorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:22.3072
                                                            longitude:73.1880
                                                                 zoom:18];
    
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
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
