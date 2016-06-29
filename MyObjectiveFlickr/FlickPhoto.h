//
//  FlickPhoto.h
//  MyObjectiveFlickr
//
//  Created by Shahid on 6/18/16.
//  Copyright © 2016 Sk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FlickPhoto : NSObject

-(id)initWithDetails:(NSDictionary *)dictionary;

@property (nonatomic,strong) NSString *photoId;
@property (nonatomic,strong) NSString *owner;
@property (nonatomic,strong) NSString *secret;
@property (nonatomic,strong) NSString *server;
@property (nonatomic,strong) NSNumber *farm;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) UIImage *image;

@property (nonatomic,strong) NSURL *url;

typedef void (^PhotoLoader) (UIImage *image);

- (void)loadImageWithCompletionBlock:(PhotoLoader) photoLoader;

@end
