//
//  DistanceViewController.m
//  Code_Library
//
//  Created by RIGEL on 3/20/17.
//  Copyright © 2017 RIGEL. All rights reserved.
//

#import "DistanceViewController.h"
#import "BaseURL+APIKey.m"
#import <GooglePlaces/GooglePlaces.h>


@interface DistanceViewController () <GMSAutocompleteViewControllerDelegate,UITextFieldDelegate>

@end

@implementation DistanceViewController {
    CLLocationDegrees latitude;
    CLLocationDegrees longitude;
    CLLocationManager *locationManager;
    CLLocationDegrees destinationLatitude;
    CLLocationDegrees destinationLongitude;
    GMSMapView *mapView;
}

/*** This method will autocomplete the search textfield ***/
// present the autocomplete view controller when the button is pressed.
//- (IBAction)onLaunchClicked:(id)sender {
//    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
//    acController.delegate = self;
//    [self presentViewController:acController animated:true completion:nil];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
    
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:latitude
                                                            longitude:longitude
                                                                 zoom:5];
    mapView = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
    mapView.myLocationEnabled = YES;
    mapView.settings.myLocationButton = YES;
    
    CLLocation *myLocation = [mapView myLocation];
    
    [self.view addSubview:mapView];
    [self.view sendSubviewToBack:mapView];
    [self distanceBetweenplaces:myLocation];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    [self presentViewController:acController animated:YES completion:nil];
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

// Handle the user's selection.
- (void)viewController:(GMSAutocompleteViewController *)viewController didAutocompleteWithPlace:(GMSPlace *)place {
    [self dismissViewControllerAnimated:YES completion:nil];
    // Do something with the selected place.
    NSLog(@"Place name %@", place.name);
    NSLog(@"Place address %@", place.formattedAddress);
    NSLog(@"Place attributions %@", place.attributions.string);
    NSLog(@"Place attributions %@", place.attributions.string);
    
}

- (void)viewController:(GMSAutocompleteViewController *)viewController didFailAutocompleteWithError:(NSError *)error {
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


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@"oldLocation %f %f", oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    NSLog(@"NewLocation %f %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    latitude = newLocation.coordinate.latitude;
    longitude = newLocation.coordinate.longitude;
    NSLog(@"latitude %f",latitude);
    NSLog(@"longitude %f",longitude);
}



/*** This method is used to get the distance between two places ***/
- (void)distanceBetweenplaces:(CLLocation *)myLocation {
    //Destination place
    latitude = myLocation.coordinate.latitude;
    longitude = myLocation.coordinate.longitude;
    destinationLatitude =   19.009944;
    destinationLongitude = 73.094389;
    
    //Create URL for request
    NSString *urlString = [NSString stringWithFormat:@"%s&origin=%f,%f&destination=%f,%f&sensor=true&key=%s",baseURLDirections,latitude,longitude,destinationLatitude,destinationLongitude,GoogleAPIKey];
    NSLog(@"URL string %@",urlString);
    NSURL *directionsURL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:directionsURL];
    NSURLResponse *response;
    NSError *error;
    
    // send request
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    if(!error) {
        // log response
        NSLog(@"Response from server = %@", responseString);
    }
}



/*** This method is used to get address from lat and long ***/
// get address from latitiude and longitiude
-(void)getAddressFromLatLon:(double)pdblLatitude withLongitude:(double)pdblLongitude
{
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&key=%s",pdblLatitude, pdblLongitude,GoogleAPIKey];
    NSLog(@"%@",url);
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //Formulate the string as a URL object.
    NSURL *googleRequestURL=[NSURL URLWithString:url];
    
    // Retrieve the results of the URL.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData* data = [NSData dataWithContentsOfURL: googleRequestURL];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:NO];
    });
}

-(void)fetchedData:(NSData *)responseData {
    if (responseData) {
        //parse out the json data
        NSError* error;
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
        NSLog(@"json : %@",[[[json valueForKey:@"results"] objectAtIndex:0] objectAtIndex:0]);
    }
}


/*** Method to get current place ***/


/*** This method is used to get the address and latitude and longitude ***/
//-(void)getAddress() {
//    
//    NSString *urlString = [NSString stringWithFormat:];
//}
//
//// Distance between two locations
//-(float)kilometersfromPlace:(CLLocationCoordinate2D)from andToPlace:(CLLocationCoordinate2D)to  {
//    
//    CLLocation *userloc = [[CLLocation alloc]initWithLatitude:from.latitude longitude:from.longitude];
//    CLLocation *dest = [[CLLocation alloc]initWithLatitude:to.latitude longitude:to.longitude];
//    
//    CLLocationDistance dist = [userloc distanceFromLocation:dest]/1000;
//    
//    //NSLog(@"%f",dist);
//    
//    NSString *distance = [NSString stringWithFormat:@"%f",dist];
//    return [distance floatValue];
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnShow:(id)sender {
    
}


-(IBAction)findAddress:(id)sender {
    
}
@end
