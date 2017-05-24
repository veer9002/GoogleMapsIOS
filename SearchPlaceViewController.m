//
//  SearchPlaceViewController.m
//  Code_Library
//
//  Created by RIGEL on 3/27/17.
//  Copyright © 2017 RIGEL. All rights reserved.
//

#import "SearchPlaceViewController.h"
#import <GooglePlaces/GooglePlaces.h>

@interface SearchPlaceViewController () <GMSAutocompleteViewControllerDelegate,UITextFieldDelegate,CLLocationManagerDelegate>

//@property(strong, nonatomic) NSURLSession *markerSession;
{
GMSCameraPosition *camera;
}
@end

@implementation SearchPlaceViewController {
    GMSMapView *mapView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    camera = [GMSCameraPosition cameraWithLatitude:22.3072 longitude:73.1812 zoom:15 bearing:0 viewingAngle:0];
    mapView = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
    mapView.myLocationEnabled = YES;
    mapView.settings.myLocationButton = YES;
    _txtSearchPlaces.delegate = self;
    [self.view addSubview:mapView];
    [self.view sendSubviewToBack:mapView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    [self presentViewController:acController animated:YES completion:nil];
    return NO;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

// Handle the user's selection.
- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {
    [self dismissViewControllerAnimated:YES completion:nil];
    // Do something with the selected place.
    NSLog(@"Place name %@", place.name);
    NSLog(@"Place address %@", place.formattedAddress);
    NSLog(@"Place attributions %@", place.attributions.string);
    _txtSearchPlaces.text = place.formattedAddress;
}

- (void)viewController:(GMSAutocompleteViewController *)viewController
didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}


// User canceled the operation.
- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Turn the network activity indicator on and off again.
- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


/** Now, find out the lat long from the searched address.
    We use Goecoding google api to find out address's lat long.
 **/

- (IBAction)btnShow:(id)sender {
    
    NSString *urlString = [NSString stringWithFormat:@"%s&address=%@&key=%s",baseURLGeoCode,_txtSearchPlaces.text,GoogleAPIKeyServer];
    NSLog(@"URL String is %@",urlString);
    
    if ([urlString containsString:@" "]) {
        urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    }
    
    NSURL *geocodeURL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:geocodeURL];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask *datatask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil) {
            if (data != nil) {
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                NSLog(@"%@",json);
                NSArray *resultData = [json valueForKey:@"results"];
                NSDictionary *locationDict = [resultData objectAtIndex:0];
                NSDictionary *geometyDict = [locationDict valueForKey:@"geometry"];
                NSDictionary *latLonDict = [geometyDict valueForKey:@"location"];
                NSString *lati = [latLonDict valueForKey:@"lat"];
                NSString *longi = [latLonDict valueForKey:@"lng"];
                
                
                CLLocationDegrees latitudeDegree = [lati doubleValue];
                CLLocationDegrees longitudeDegree = [longi doubleValue];
                
                NSLog(@"Latitude is %@", lati);
                NSLog(@"Longitude is %@", longi);
                dispatch_async(dispatch_get_main_queue(), ^{
//                    [mapView removeFromSuperview];
//                    camera = [GMSCameraPosition cameraWithLatitude:latitudeDegree longitude:longitudeDegree zoom:20 bearing:0 viewingAngle:0];
//                    mapView = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
                   
                    [mapView animateToLocation:CLLocationCoordinate2DMake(latitudeDegree, longitudeDegree)];
                    
                    GMSMarker *marker2 = [[GMSMarker alloc]init];
                    marker2.position = CLLocationCoordinate2DMake(latitudeDegree, longitudeDegree);
                    marker2.icon = [GMSMarker markerImageWithColor:[UIColor redColor]];
                    marker2.map = mapView;
                    [mapView setMapType:kGMSTypeNormal];
                    [self.view addSubview:mapView];
                    [self.view bringSubviewToFront:mapView];

                });
                
            }
        }
    }];
    [datatask resume];
    
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
