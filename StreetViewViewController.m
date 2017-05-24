//
//  StreetViewViewController.m
//  Code_Library
//
//  Created by RIGEL on 3/17/17.
//  Copyright © 2017 RIGEL. All rights reserved.
//

#import "StreetViewViewController.h"
@import GoogleMaps;

@interface StreetViewViewController ()

@end

@implementation StreetViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    CLLocationCoordinate2D panoramaNear = {50.059139,-122.958391};
    CLLocationCoordinate2D panoramaNear = {48.858,2.294};
    
    GMSPanoramaView *panoView =
    [GMSPanoramaView panoramaWithFrame:CGRectZero
                        nearCoordinate:panoramaNear];
    
    self.view = panoView;
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
