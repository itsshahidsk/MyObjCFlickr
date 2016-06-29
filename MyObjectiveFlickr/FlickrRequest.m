//
//  FlickrRequest.m
//  MyObjectiveFlickr
//
//  Created by Shahid on 6/18/16.
//  Copyright © 2016 Sk. All rights reserved.
//



#import "FlickrRequest.h"
#import <Foundation/Foundation.h>
#import "FlickPhoto.h"

#define kAPIKey @"dc29c800c34e2955c179219f36bc7d83"


@implementation FlickrRequest


//        let urlString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(kAPIKey)&text=\(searchURLAllowedText)&per_page=30&page=\(page)&format=json&nojsoncallback=1"

-(void)searchFlickrPhotosWithText:(NSString *) text andCompletionBlock:(CompletionBlock) completionBlock {

    NSString *urlString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&text=%@&per_page=30&page=%d&format=json&nojsoncallback=1",kAPIKey,text,1];
    NSURL *url = [[NSURL alloc] initWithString:urlString];

    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *dataTask = [urlSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

        if (error) {
            completionBlock(error,nil,false);
        } else {
            NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",jsonString);
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSArray *photos = [self getPhotosFromResponse:responseDictionary];
            completionBlock(nil,photos,true);
        }
    }];

    [dataTask resume];
}

-(NSArray *)getPhotosFromResponse:(NSDictionary *) response {

    NSMutableArray *photosArray = [NSMutableArray new];
    NSDictionary *photosDictionary = response[@"photos"];

    for (NSDictionary *photo in photosDictionary[@"photo"]) {
        FlickPhoto *flickerPhoto = [[FlickPhoto alloc] initWithDetails:photo];
        [photosArray addObject:flickerPhoto];
    }

    return photosArray;
}

@end
