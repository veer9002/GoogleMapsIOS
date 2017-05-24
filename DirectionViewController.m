//
//  DirectionViewController.m
//  Code_Library
//
//  Created by RIGEL on 3/29/17.
//  Copyright © 2017 RIGEL. All rights reserved.
//

#import "DirectionViewController.h"

@interface DirectionViewController ()
{
    UITextField *txtCommon;
    GMSMapView *mapView;
}
@end

@implementation DirectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
 /*** Native map view ***/
//    MKMapView *mapViewNative = [[MKMapView alloc] initWithFrame:self.view.bounds];
//    mapViewNative.delegate = self;
//    mapViewNative.showsUserLocation = YES;
//    mapViewNative.zoomEnabled = YES;
//    [self.view addSubview:mapViewNative];
    
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:22.3072 longitude:73.1812 zoom:10 bearing:0 viewingAngle:0];
    mapView = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
    mapView.myLocationEnabled = YES;
    mapView.settings.myLocationButton = YES;
    [self.view addSubview:mapView];
    [self.view sendSubviewToBack:mapView];
    _txtDestination.delegate = self;
    _txtStartLocation.delegate = self;
    
}

/*** AutoComplete textfield ***/
# pragma mark Textfield Delegates

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    txtCommon = textField;
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
# pragma mark Autocomplete controller

- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    // Do something with the selected place.
    if (_txtStartLocation == txtCommon) {
       NSLog(@"Place name %@", place.name);
       NSLog(@"Place address %@", place.formattedAddress);
       NSLog(@"Place attributions %@", place.attributions.string);
       _txtStartLocation.text = place.formattedAddress;
        
    } else if (_txtDestination == txtCommon) {
        NSLog(@"Place name %@", place.name);
        NSLog(@"Place address %@", place.formattedAddress);
        NSLog(@"Place attributions %@", place.attributions.string);
        _txtDestination.text = place.formattedAddress;
    }
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



/*** Button to show directions for showing the directions in map ***/
- (IBAction)btnShowDirections:(id)sender {
   
    // sample URL format
//    https://maps.googleapis.com/maps/api/directions/json?origin=75+9th+Ave+New+York,+NY&destination=MetLife+Stadium+1+MetLife+Stadium+Dr+East+Rutherford,+NJ+07073&key=YOUR_API_KEY
  
    NSString *urlString = [NSString stringWithFormat:@"%s&origin=%@&destination=%@&key=%s",baseURLDirections,self.txtStartLocation.text,self.txtDestination.text,GoogleAPIKeyServer];
    if ([urlString containsString:@" "]) {
        urlString = [urlString stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    }
    NSURL *directionUrl= [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:directionUrl];
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error == nil) {
            if (data != nil) {
                
                // fetch and store the response in json.
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                NSLog(@"json %@",json);
                // store value of routes from json in an array.
                NSArray *routes =  [json valueForKey:@"routes"];
                // store routes object at index 0 in routesData
                NSDictionary *routesData = [routes objectAtIndex:0];
                // from routes data store legs data in legsDataArray array.
                NSArray *legsDataArray = [routesData valueForKey:@"legs"];
                NSDictionary *legsData = [legsDataArray objectAtIndex:0];
                NSLog(@"Legs Data is %@", legsData);
                
                //from legsData dictionary fetch the value of distance
                NSDictionary *distance = [legsData valueForKey:@"distance"];
                NSLog(@"Distance data is %@", distance);
                // store the value of 'text' fetched from distance dictionary.
                NSString *kms = [distance valueForKey:@"text"];
                NSLog(@"kms is %@", kms);
                
                // store total time to be consumed while travelling by road.
                NSDictionary *travelTimeData = [legsData valueForKey:@"duration"];
                NSLog(@"Duration data is %@",travelTimeData);
                // store the value of 'text'(duration) in duration.
                NSString *duration = [travelTimeData valueForKey:@"text"];
                NSLog(@"Total time to reached destination could be %@",duration);
                
                // starting location latitude and longitutde.
                NSDictionary *startLatLong = [legsData valueForKey:@"start_location"];
                NSLog(@"Lat and long values of starting place is %@", startLatLong);
                // store latitude and longtitude
                NSString *latitudeStart = [startLatLong valueForKey:@"lat"];
//                double latitudeStart = [[startLatLong valueForKey:@"lat"] doubleValue];
                NSLog(@"Latitude of starting location is %@", latitudeStart);
                NSString *longStart = [startLatLong valueForKey:@"lng"];
                NSLog(@"Longitude of ending location is %@", longStart);
                
               // destination location latitude and longitude
                NSDictionary *destination = [legsData valueForKey:@"end_location"];
                NSLog(@"Destination's lat lng is %@", destination);
                // store lat and lng
                NSString *destlat = [destination valueForKey:@"lat"];
                NSLog(@"Destination lat is %@", destlat);
                NSString *destlng = [destination valueForKey:@"lng"];
                NSLog(@"Destination lng is %@", destlng);

//                NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
//                f.numberStyle = NSNumberFormatterDecimalStyle;
//                NSNumber *myNumber = [f numberFromString:latitudeStart];
                
                CLLocationDegrees startLat = [latitudeStart doubleValue]; //latitudeStart;//[myNumber doubleValue];
                CLLocationDegrees startLng = [longStart doubleValue];
                CLLocationDegrees destinationLat = [destlat doubleValue];
                CLLocationDegrees destinationLng = [destlng doubleValue];
                
                
                GMSMarker *marker = [[GMSMarker alloc] init];
                marker.position = CLLocationCoordinate2DMake(startLat, startLng);
                marker.appearAnimation = kGMSMarkerAnimationPop;
                NSString *infoWindow = [NSString stringWithFormat:@"Distance is %@",kms];
//                NSString *totalTime = [NSString stringWithFormat:@"Time to reach destination %@",duration];
                marker.snippet = infoWindow;
                marker.icon = [GMSMarker markerImageWithColor:[UIColor redColor]];
                marker.map = mapView;
                [mapView animateToLocation:CLLocationCoordinate2DMake(startLat, startLng)];
                
                GMSMarker *marker2 = [[GMSMarker alloc] init];
                marker2.position = CLLocationCoordinate2DMake(destinationLat, destinationLng);
                marker2.icon = [GMSMarker markerImageWithColor:[UIColor redColor]];
                marker2.map = mapView;
                
                GMSPath *path = [GMSPath pathFromEncodedPath:json[@"routes"][0][@"overview_polyline"][@"points"]];
                GMSPolyline *singleLine = [GMSPolyline polylineWithPath:path];
                singleLine.title = @"ddsfgsadhdfh";
                singleLine.strokeWidth = 7;
                singleLine.strokeColor = [UIColor blueColor];
                singleLine.map = mapView;
                
            }
        }
    }];
    [dataTask resume];
    
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
