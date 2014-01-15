//
//  TRIFeedsTableViewController.m
//  Tribbble
//
//  Created by Zihua Li on 1/15/14.
//  Copyright (c) 2014 Zihua Li. All rights reserved.
//

#import "TRIFeedsTableViewController.h"
#import "../Views/TRIShotsTableViewCell.h"
#import "TRIShotDetailViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface TRIFeedsTableViewController ()
@property (nonatomic, retain) NSMutableArray *shots;
@property (nonatomic) NSInteger currentPage;
@property (nonatomic) BOOL isLoading;
@end

@implementation TRIFeedsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
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

- (void)loadMoreShots
{
    if (self.isLoading) {
        return;
    }
    self.isLoading = true;
    self.currentPage += 1;
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *player = [defaults objectForKey:@"player"];
    if (player == nil) {
        player = @"luin";
    }

    [manager GET:[NSString stringWithFormat:@"http://api.dribbble.com/players/%@/shots/following?per_page=30&page=%d", player, (int)self.currentPage] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = responseObject;
        [self.shots addObjectsFromArray:[dict objectForKey:@"shots"]];
        [self.tableView reloadData];
        self.isLoading = false;
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

- (void) prepareView
{
    [self.view setBackgroundColor:[UIColor colorWithRed:0.922 green:0.922 blue:0.922 alpha:1.0]];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
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

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shots.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TRIShotDetailViewController *vc = [[TRIShotDetailViewController alloc] initWithNibName:nil bundle:nil];
    vc.shotId = [[self.shots objectAtIndex:indexPath.row] objectForKey:@"id"];
    
    TRIShotsTableViewCell *cell = (TRIShotsTableViewCell *)[tableView
                                                                      cellForRowAtIndexPath:indexPath];
    
    vc.placeholderImage = cell.shotImage.image;
    vc.imageURL = [[self.shots objectAtIndex:indexPath.row] objectForKey:@"image_url"];
    vc.placeholderTitle = [[self.shots objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TRIShotsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeedCell"];
    if (cell == nil) {
        cell = [[TRIShotsTableViewCell alloc] init];
    }
    
    NSLog(@"%@", [self.shots objectAtIndex:indexPath.row]);
    cell.viewsLabel.text = [NSString stringWithFormat:@"%@ views", [[self.shots objectAtIndex:indexPath.row] objectForKey:@"views_count"]];
    cell.likesLabel.text = [NSString stringWithFormat:@"%@ likes", [[self.shots objectAtIndex:indexPath.row] objectForKey:@"likes_count"]];
    cell.commentsLabel.text = [NSString stringWithFormat:@"%@ comments", [[self.shots objectAtIndex:indexPath.row] objectForKey:@"comments_count"]];

    cell.authorLabel.text = [[[self.shots objectAtIndex:indexPath.row] objectForKey:@"player"] objectForKey:@"name"];
    [cell.shotImage setImageWithURL:[NSURL URLWithString:[[self.shots objectAtIndex:indexPath.row]
                                                          objectForKey:@"image_teaser_url"]]];
    
    if (indexPath.row == self.shots.count - 1 - 18) {
        [self loadMoreShots];
    }

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
