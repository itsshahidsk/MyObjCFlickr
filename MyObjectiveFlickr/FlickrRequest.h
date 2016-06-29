//
//  FlickrRequest.h
//  MyObjectiveFlickr
//
//  Created by Shahid on 6/18/16.
//  Copyright © 2016 Sk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlickrRequest : NSObject


typedef void (^CompletionBlock) (NSError *error, NSArray *photos, BOOL success);

-(void)searchFlickrPhotosWithText:(NSString *) text andCompletionBlock:(CompletionBlock) completionBlock;

@end
