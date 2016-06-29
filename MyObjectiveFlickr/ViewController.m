//
//  ViewController.m
//  MyObjectiveFlickr
//
//  Created by Shahid on 6/18/16.
//  Copyright © 2016 Sk. All rights reserved.
//

#import "ViewController.h"
#import "FlickrRequest.h"
#import "FlickrPhotosViewController.h"

#define FlickrPhotosSegueIdentifier @"flickrPhotosSegue"

@interface ViewController ()<UITextFieldDelegate>

@property(strong, nonatomic) NSArray *photos;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)didClickSearch:(id)sender {
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.hidesWhenStopped = true;
    [activityIndicator startAnimating];
    //Create Flickr Request Object and Search
    FlickrRequest * flickrRequest = [[FlickrRequest alloc] init];
    [flickrRequest searchFlickrPhotosWithText:self.searchTextField.text andCompletionBlock:^(NSError *error, NSArray *photos, BOOL success) {
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [activityIndicator stopAnimating];
                self.photos = photos;
                NSLog(@"%@",self.photos);
                [self performSegueWithIdentifier:FlickrPhotosSegueIdentifier sender:self];
            });
        } else {
            NSLog(@"Error is %@",error.description);
        }
    }];

}


#pragma mark - Text Field Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.searchTextField resignFirstResponder];
    return  true;
}


#pragma mark - Preparung For Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    FlickrPhotosViewController *photosViewController = [segue destinationViewController];
    photosViewController.photos = self.photos;
}



@end
