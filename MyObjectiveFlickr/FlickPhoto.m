//
//  FlickPhoto.m
//  MyObjectiveFlickr
//
//  Created by Shahid on 6/18/16.
//  Copyright © 2016 Sk. All rights reserved.
//

#import "FlickPhoto.h"

@implementation FlickPhoto

-(id)initWithDetails:(NSDictionary *)dictionary {

    self = [super init];

    if (self) {
        self.photoId = dictionary[@"id"];
        self.owner = dictionary[@"owner"];
        self.secret = dictionary[@"secret"];
        self.server = dictionary[@"server"];
        self.farm = dictionary[@"farm"];
        self.title = dictionary[@"title"];
        //https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
        NSString *urlString = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@_%@.jpg",self.farm,self.server,self.photoId,self.secret,@"m"];
        self.url = [NSURL URLWithString:urlString];
    }

    return  self;
}


- (void)loadImageWithCompletionBlock:(PhotoLoader) photoLoader {
    NSOperationQueue *imageLoaderOperationQueue = [[NSOperationQueue alloc] init];
    [imageLoaderOperationQueue addOperationWithBlock:^{
        UIImage *image = [self loadImageWithURL:self.url];

        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            photoLoader(image);
        }];

    }];
}

-(UIImage *)loadImageWithURL:(NSURL *)url {

    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}

@end
