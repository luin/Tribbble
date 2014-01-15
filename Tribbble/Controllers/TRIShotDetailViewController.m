//
//  TRIShotDetailViewController.m
//  Tribbble
//
//  Created by Zihua Li on 1/15/14.
//  Copyright (c) 2014 Zihua Li. All rights reserved.
//

#import "TRIShotDetailViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface TRIShotDetailViewController ()
@property (nonatomic, retain) UIImageView *shotView;
@property (nonatomic, retain) UIImageView *shotPlaceholderView;
@property (nonatomic, retain) UIScrollView *scrollView;
@end

@implementation TRIShotDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.placeholderTitle;
    [self prepareView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    NSString *url = [NSString stringWithFormat:@"http://api.dribbble.com/shots/%@", self.shotId];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = responseObject;
        self.title = [dict objectForKey:@"title"];
        [self.shotView setImageWithURL:[NSURL URLWithString:[dict objectForKey:@"image_url"]]
                      placeholderImage:self.placeholderImage];
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

- (void)prepareView
{
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.scrollView];

    self.shotView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 240)];
    [self.shotView setImage: self.placeholderImage];
    [self.scrollView addSubview:self.shotView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
