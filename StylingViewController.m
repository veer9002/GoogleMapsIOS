//
//  StylingViewController.m
//  Code_Library
//
//  Created by RIGEL on 3/17/17.
//  Copyright © 2017 RIGEL. All rights reserved.
//

#import "StylingViewController.h"
@import GoogleMaps;
static NSString *const kMapStyle = @"["
                                        @"  {"
                                        @"    \"featureType\": \"all\","
                                        @"    \"elementType\": \"geometry\","
                                        @"    \"stylers\": ["
                                        @"      {"
                                        @"        \"color\": \"#242f3e\""
                                        @"      }"
                                        @"    ]"
                                        @"  },"
                                        @"  {"
                                        @"    \"featureType\": \"all\","
                                        @"    \"elementType\": \"labels.text.stroke\","
                                        @"    \"stylers\": ["
                                        @"      {"
                                        @"        \"lightness\": -80"
                                        @"      }"
                                        @"    ]"
                                        @"  },"
                                        @"  {"
                                        @"    \"featureType\": \"administrative\","
                                        @"    \"elementType\": \"labels.text.fill\","
                                        @"    \"stylers\": ["
                                        @"      {"
                                        @"        \"color\": \"#746855\""
                                        @"      }"
                                        @"    ]"
                                        @"  },"
                                        @"  {"
                                        @"    \"featureType\": \"administrative.locality\","
                                        @"    \"elementType\": \"labels.text.fill\","
                                        @"    \"stylers\": ["
                                        @"      {"
                                        @"        \"color\": \"#d59563\""
                                        @"      }"
                                        @"    ]"
                                        @"  },"
                                        @"  {"
                                        @"    \"featureType\": \"poi\","
                                        @"    \"elementType\": \"labels.text.fill\","
                                        @"    \"stylers\": ["
                                        @"      {"
                                        @"        \"color\": \"#d59563\""
                                        @"      }"
                                        @"    ]"
                                        @"  },"
                                        @"  {"
                                        @"    \"featureType\": \"poi.park\","
                                        @"    \"elementType\": \"geometry\","
                                        @"    \"stylers\": ["
                                        @"      {"
                                        @"        \"color\": \"#263c3f\""
                                        @"      }"
                                        @"    ]"
                                        @"  },"
                                        @"  {"
                                        @"    \"featureType\": \"poi.park\","
                                        @"    \"elementType\": \"labels.text.fill\","
                                        @"    \"stylers\": ["
                                        @"      {"
                                        @"        \"color\": \"#6b9a76\""
                                        @"      }"
                                        @"    ]"
                                        @"  },"
                                        @"  {"
                                        @"    \"featureType\": \"road\","
                                        @"    \"elementType\": \"geometry.fill\","
                                        @"    \"stylers\": ["
                                        @"      {"
                                        @"        \"color\": \"#2b3544\""
                                        @"      }"
                                        @"    ]"
                                        @"  },"
                                        @"  {"
                                        @"    \"featureType\": \"road\","
                                        @"    \"elementType\": \"labels.text.fill\","
                                        @"    \"stylers\": ["
                                        @"      {"
                                        @"        \"color\": \"#9ca5b3\""
                                        @"      }"
                                        @"    ]"
                                        @"  },"
                                        @"  {"
                                        @"    \"featureType\": \"road.arterial\","
                                        @"    \"elementType\": \"geometry.fill\","
                                        @"    \"stylers\": ["
                                        @"      {"
                                        @"        \"color\": \"#38414e\""
                                        @"      }"
                                        @"    ]"
                                        @"  },"
                                        @"  {"
                                        @"    \"featureType\": \"road.arterial\","
                                        @"    \"elementType\": \"geometry.stroke\","
                                        @"    \"stylers\": ["
                                        @"      {"
                                        @"        \"color\": \"#212a37\""
                                        @"      }"
                                        @"    ]"
                                        @"  },"
                                        @"  {"
                                        @"    \"featureType\": \"road.highway\","
                                        @"    \"elementType\": \"geometry.fill\","
                                        @"    \"stylers\": ["
                                        @"      {"
                                        @"        \"color\": \"#746855\""
                                        @"      }"
                                        @"    ]"
                                        @"  },"
                                        @"  {"
                                        @"    \"featureType\": \"road.highway\","
                                        @"    \"elementType\": \"geometry.stroke\","
                                        @"    \"stylers\": ["
                                        @"      {"
                                        @"        \"color\": \"#1f2835\""
                                        @"      }"
                                        @"    ]"
                                        @"  },"
                                        @"  {"
                                        @"    \"featureType\": \"road.highway\","
                                        @"    \"elementType\": \"labels.text.fill\","
                                        @"    \"stylers\": ["
                                        @"      {"
                                        @"        \"color\": \"#f3d19c\""
                                        @"      }"
                                        @"    ]"
                                        @"  },"
                                        @"  {"
                                        @"    \"featureType\": \"road.local\","
                                        @"    \"elementType\": \"geometry.fill\","
                                        @"    \"stylers\": ["
                                        @"      {"
                                        @"        \"color\": \"#38414e\""
                                        @"      }"
                                        @"    ]"
                                        @"  },"
                                        @"  {"
                                        @"    \"featureType\": \"road.local\","
                                        @"    \"elementType\": \"geometry.stroke\","
                                        @"    \"stylers\": ["
                                        @"      {"
                                        @"        \"color\": \"#212a37\""
                                        @"      }"
                                        @"    ]"
                                        @"  },"
                                        @"  {"
                                        @"    \"featureType\": \"transit\","
                                        @"    \"elementType\": \"geometry\","
                                        @"    \"stylers\": ["
                                        @"      {"
                                        @"        \"color\": \"#2f3948\""
                                        @"      }"
                                        @"    ]"
                                        @"  },"
                                        @"  {"
                                        @"    \"featureType\": \"transit.station\","
                                        @"    \"elementType\": \"labels.text.fill\","
                                        @"    \"stylers\": ["
                                        @"      {"
                                        @"        \"color\": \"#d59563\""
                                        @"      }"
                                        @"    ]"
                                        @"  },"
                                        @"  {"
                                        @"    \"featureType\": \"water\","
                                        @"    \"elementType\": \"geometry\","
                                        @"    \"stylers\": ["
                                        @"      {"
                                        @"        \"color\": \"#17263c\""
                                        @"      }"
                                        @"    ]"
                                        @"  },"
                                        @"  {"
                                        @"    \"featureType\": \"water\","
                                        @"    \"elementType\": \"labels.text.fill\","
                                        @"    \"stylers\": ["
                                        @"      {"
                                        @"        \"color\": \"#515c6d\""
                                        @"      }"
                                        @"    ]"
                                        @"  },"
                                        @"  {"
                                        @"    \"featureType\": \"water\","
                                        @"    \"elementType\": \"labels.text.stroke\","
                                        @"    \"stylers\": ["
                                        @"      {"
                                        @"        \"lightness\": -20"
                                        @"      }"
                                        @"    ]"
                                        @"  }"
                                        @"]";

@interface StylingViewController ()
@end

@implementation StylingViewController

// Set the status bar style to complement night-mode.
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)loadView {
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:22.3072
                                                            longitude:73.1880
                                                                 zoom:12];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    mapView.settings.myLocationButton = YES;
    mapView.mapType = kGMSTypeNormal;
//    NSBundle *mainBundle = [NSBundle mainBundle];
//    NSURL *styleUrl = [mainBundle URLForResource:@"style" withExtension:@"json"];
    NSError *error;
//
//    
//    // Set the map style by passing the URL for style.json.
//    GMSMapStyle *style = [GMSMapStyle styleWithContentsOfFileURL:styleUrl error:&error];
    GMSMapStyle *style = [GMSMapStyle styleWithJSONString:kMapStyle error:&error];
    
    if (!style) {
        NSLog(@"The style definition could not be loaded: %@", error);
    }
    
    mapView.mapStyle = style;
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
