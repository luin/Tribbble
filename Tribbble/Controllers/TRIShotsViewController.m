//
//  TRIShotsViewController.m
//  Tribbble
//
//  Created by Zihua Li on 1/15/14.
//  Copyright (c) 2014 Zihua Li. All rights reserved.
//

#import "TRIShotsViewController.h"
#import "../Views/TRIShotsCollectionViewCell.h"
#import "TRIShotDetailViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <NJKScrollFullScreen/NJKScrollFullScreen.h>
#import "UIViewController+NJKFullScreenSupport.h"

@interface TRIShotsViewController () <UICollectionViewDataSource, UICollectionViewDelegate, NJKScrollFullscreenDelegate>
@property (nonatomic, retain) UICollectionView *shotsView;
@property (nonatomic, retain) NSMutableArray *shots;
@property (nonatomic) NSInteger currentPage;
@property (nonatomic) BOOL isLoading;
@property (nonatomic, retain) NJKScrollFullScreen *scrollProxy;
@end

@implementation TRIShotsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.shots = [[NSMutableArray alloc] init];
    [self prepareView];
    
    self.currentPage = 0;
    self.isLoading = false;
	[self loadMoreShots];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self showNavigationBar:YES];
}

- (void)loadMoreShots
{
    if (self.isLoading) {
        return;
    }
    self.isLoading = true;
    self.currentPage += 1;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"http://api.dribbble.com/shots/%@?per_page=30&page=%d", [self.title lowercaseString], (int)self.currentPage] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = responseObject;
        [self.shots addObjectsFromArray:[dict objectForKey:@"shots"]];
        NSLog(@"URL== %@", [[self.shots objectAtIndex:0] objectForKey:@"image_teaser_url"]);
        [self.shotsView reloadData];
        self.isLoading = false;
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

- (void) prepareView
{
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UICollectionViewFlowLayout *flowLayout =
    [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumLineSpacing = 4.0f;
    flowLayout.minimumInteritemSpacing = 0.0f;
    flowLayout.itemSize = CGSizeMake(104.0f, 78.0f);
    
    self.shotsView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)
                                        collectionViewLayout:flowLayout];
    [self.shotsView setBackgroundColor: [UIColor whiteColor]];
    self.shotsView.delegate = self;
    self.shotsView.dataSource = self;
    
    self.scrollProxy = [[NJKScrollFullScreen alloc] initWithForwardTarget:self];
    self.shotsView.delegate = (id)_scrollProxy;
    self.scrollProxy.delegate = self;
    

    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.shotsView addSubview:refreshControl];
    
    
    static NSString *CellIdentifier = @"ShotCell";
    
    [self.shotsView registerClass:[TRIShotsCollectionViewCell class]
       forCellWithReuseIdentifier:CellIdentifier];
    
    [self.view addSubview:self.shotsView];
}


- (void) handleRefresh:(id)sender
{
    [(UIRefreshControl *)sender endRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.shots.count;
}

-(void)fadeIn:(UIView*)viewToFadeIn
 withDuration:(NSTimeInterval)duration
      andWait:(NSTimeInterval)wait
{
    viewToFadeIn.alpha = 0;
    [UIView beginAnimations: @"Fade In" context:nil];
    
    // wait for time before begin
    [UIView setAnimationDelay:wait];
    
    // druation of animation
    [UIView setAnimationDuration:duration];
    viewToFadeIn.alpha = 1;
    [UIView commitAnimations];
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ShotCell";
    TRIShotsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [cell.shotImage setImageWithURL:[NSURL URLWithString:[[self.shots objectAtIndex:indexPath.row]
                                                          objectForKey:@"image_teaser_url"]]
                   placeholderImage:[UIImage imageNamed:@"placeholder"]
                            options:SDWebImageRetryFailed];
    
    if (indexPath.row == self.shots.count - 1 - 18) {
        [self loadMoreShots];
    }
    
    return cell;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TRIShotDetailViewController *vc = [[TRIShotDetailViewController alloc] initWithNibName:nil bundle:nil];
    vc.shotId = [[self.shots objectAtIndex:indexPath.row] objectForKey:@"id"];
    
    TRIShotsCollectionViewCell *cell = (TRIShotsCollectionViewCell *)[collectionView
                                                                      cellForItemAtIndexPath:indexPath];

    vc.placeholderImage = cell.shotImage.image;
    vc.imageURL = [[self.shots objectAtIndex:indexPath.row] objectForKey:@"image_url"];
    vc.placeholderTitle = [[self.shots objectAtIndex:indexPath.row] objectForKey:@"title"];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)scrollFullScreen:(NJKScrollFullScreen *)proxy scrollViewDidScrollUp:(CGFloat)deltaY
{
    [self moveNavigtionBar:deltaY animated:YES];
}

- (void)scrollFullScreen:(NJKScrollFullScreen *)proxy scrollViewDidScrollDown:(CGFloat)deltaY
{
    [self moveNavigtionBar:deltaY animated:YES];
}

- (void)scrollFullScreenScrollViewDidEndDraggingScrollUp:(NJKScrollFullScreen *)proxy
{
    [self hideNavigationBar:YES];
}

- (void)scrollFullScreenScrollViewDidEndDraggingScrollDown:(NJKScrollFullScreen *)proxy
{
    [self showNavigationBar:YES];
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
