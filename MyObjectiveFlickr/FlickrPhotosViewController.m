//
//  FlickrPhotosViewController.m
//  MyObjectiveFlickr
//
//  Created by Shahid on 6/20/16.
//  Copyright © 2016 Sk. All rights reserved.
//

#import "FlickrPhotosViewController.h"
#import "FlickrPhotoCell.h"
#import "FlickPhoto.h"


@implementation FlickrPhotosViewController


-(void)viewDidLoad {
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

#pragma mark - CollectionView Delegate Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photos.count;
}


// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FlickrPhotoCell *cell = (FlickrPhotoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"FlickrPhotoCell" forIndexPath:indexPath];
    FlickPhoto *photo = self.photos[indexPath.row];
    if (photo.image == nil) {
        cell.imageView.image  = [UIImage imageNamed:@"placeholderPhoto"];
        [self imageWithURL:photo.url andImageBlock:^(UIImage *image) {
            dispatch_async(dispatch_get_main_queue(), ^{
               // FlickPhoto *photo = self.photos[indexPath.row];
                photo.image = image;
                //FlickrPhotoCell *cell = (FlickrPhotoCell *)[collectionView cellForItemAtIndexPath:indexPath];
                cell.imageView.image = image;
            });
        }];
    } else {
        cell.imageView.image = photo.image;
    }


    return cell;
}

#pragma mark - Collection View Flow Layout Delegate Methods

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = self.view.bounds.size.width/3;
    CGFloat height = (width/4) * 3 ;
    return CGSizeMake(width, height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}



#pragma mark - Loading Images

- (void) imageWithURL:(NSURL *)url andImageBlock:(PhotoLoader) photoLoader {

//    __weak typeof(self) weakself = self;
//    dispatch_queue_t myqueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(myqueue, ^{
//        UIImage *image = [weakself loadImageWithURL:url];
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//        });
//
//    });

//    dispatch_queue_t imageLoaderQueue = dispatch_get_global_queue(QOS_CLASS_BACKGROUND,0);
//
//    dispatch_async(imageLoaderQueue,^{
//        UIImage *image = [self loadImageWithURL:url];
//        dispatch_async(dispatch_get_main_queue(),^{
//            photoLoader(image);
//        });
//    });


    NSOperationQueue *imageLoaderOperationQueue = [[NSOperationQueue alloc] init];
    [imageLoaderOperationQueue addOperationWithBlock:^{
        UIImage *image = [self loadImageWithURL:url];

            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                photoLoader(image);
            }];

    }];

   // [imageLoaderOperationQueue cancelAllOperations];

//    NSURLSession *imageLoadingSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    NSURLSessionDataTask *dataTask = [imageLoadingSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//
//        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//
//
//    }];

}

-(UIImage *)loadImageWithURL:(NSURL *)url {

    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:data];
    return image;
}


- (void) loadWithImage {
//    NSURLSession *imageLoadingSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//    NSURLSessionDataTask *dataTask = [imageLoadingSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        if (error) {
//            NSLog(@"Could not load the image");
//            photoLoader(nil);
//        } else {
//            UIImage *image = [UIImage imageWithData:data];
//            photoLoader(image);
//        }
//    }];
//    [dataTask resume];

}




@end
