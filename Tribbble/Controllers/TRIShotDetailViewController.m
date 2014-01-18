//
//  TRIShotDetailViewController.m
//  Tribbble
//
//  Created by Zihua Li on 1/15/14.
//  Copyright (c) 2014 Zihua Li. All rights reserved.
//

#import "TRIShotDetailViewController.h"
#import "../Views/TRICommentTableViewCell.h"
#import <AFNetworking/AFNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <FXBlurView/FXBlurView.h>
#import <DACircularProgress/DACircularProgressView.h>
#import "UIViewController+NJKFullScreenSupport.h"

@interface TRIShotDetailViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, retain) UIImageView *shotView;
@property (nonatomic, retain) UIImageView *shotPlaceholderView;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UITableView *commentView;
@property (nonatomic, retain) NSArray *comments;
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
    [self showNavigationBar:YES];

    self.title = self.placeholderTitle;
    [self prepareView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    NSString *url = [NSString stringWithFormat:@"http://api.dribbble.com/shots/%@/comments?per_page=30", self.shotId];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = responseObject;
        self.comments = [dict objectForKey:@"comments"];
        self.commentView = [[UITableView alloc] initWithFrame:CGRectMake(15, 255, 290, 60 * self.comments.count)];
        self.commentView.dataSource = self;
        self.commentView.delegate = self;
        self.commentView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.commentView.alwaysBounceVertical = NO;
        [self.scrollView addSubview:self.commentView];
        self.scrollView.contentSize = CGSizeMake(320, self.commentView.frame.size.height + self.commentView.frame.origin.y);
        [self.commentView reloadData];
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
    
    [self.shotView setImage:[self.placeholderImage blurredImageWithRadius:8.0f iterations:2 tintColor:[UIColor clearColor]]];

    DACircularProgressView *progressView = [[DACircularProgressView alloc] initWithFrame:CGRectMake(140.0f, 100.0f, 40.0f, 40.0f)];
    progressView.roundedCorners = YES;
    progressView.trackTintColor = [UIColor clearColor];
    [self.shotView addSubview:progressView];
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadWithURL:self.imageURL
                     options:0
                    progress:^(NSUInteger receivedSize, long long expectedSize)
     {
         [progressView setProgress:(CGFloat)receivedSize/expectedSize];
     }
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished)
     {
         if (image)
         {
             [self.shotView setImage:image];
             [progressView removeFromSuperview];
         }
     }];

    
    [self.scrollView addSubview:self.shotView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.comments.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TRICommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeedCell"];
    if (cell == nil) {
        cell = [[TRICommentTableViewCell alloc] init];
    }
    [cell updateComment:[self.comments objectAtIndex:indexPath.row]];
    return cell;
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
