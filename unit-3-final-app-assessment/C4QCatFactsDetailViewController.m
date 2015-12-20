//
//  C4QCatFactDetailViewController.m
//  unit-3-final-app-assessment
//
//  Created by Michael Kavouras on 12/18/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//
#import <AFNetworking/AFNetworking.h>

#import "C4QCatFactsDetailViewController.h"

#define CAT_GIF_URL @"http://api.giphy.com/v1/gifs/search?q=funny+cat&api_key=dc6zaTOxFJmzC"

@interface C4QCatFactsDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *catFactLabel;
@property (weak, nonatomic) IBOutlet UIImageView *catGiphyImageView;

@end

@implementation C4QCatFactsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.catFactLabel.text = self.catFact;
    self.catGiphyImageView.clipsToBounds = YES;
    
    [self getBackgroundImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getBackgroundImage {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:CAT_GIF_URL
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSArray *data = responseObject[@"data"];
             int randomNumber = (arc4random() % data.count) + 1;
             NSString *imageURLString = data[randomNumber][@"images"][@"fixed_height_still"][@"url"];
             
             NSURL *imageURL = [NSURL URLWithString:imageURLString];
             
             NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
             
             UIImage *image = [UIImage imageWithData:imageData];
             
             [self.catGiphyImageView setImage:image];
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"Error: %@", error);
         }];
}

@end
