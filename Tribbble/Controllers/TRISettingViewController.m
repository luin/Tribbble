//
//  TRISettingTableViewController.m
//  Tribbble
//
//  Created by Zihua Li on 1/15/14.
//  Copyright (c) 2014 Zihua Li. All rights reserved.
//

#import "TRISettingViewController.h"
#import <RETableViewManager/RETableViewManager.h>

@interface TRISettingViewController ()
@property (nonatomic, retain) RETableViewManager *manager;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) RETextItem *usernameItem;
@end

@implementation TRISettingViewController

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
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 44 + 20, 320, self.view.frame.size.height - 44 - 20)];
    [self.view addSubview:self.tableView];
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableView];
    
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"Basic"];
    [self.manager addSection:section];

    RETableViewSection *sectionLinks = [RETableViewSection sectionWithHeaderTitle:@"Links"];
    [self.manager addSection:sectionLinks];
    
    [sectionLinks addItemsFromArray:@[@"Rate us", @"@Luin", @"Website", @"Feedback"]];

    self.usernameItem = [RETextItem itemWithTitle:@"Account" value:@"" placeholder:@"Dribbbil username"];
    [section addItem:self.usernameItem];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *player = [defaults objectForKey:@"player"];
    if (player) {
        [self.usernameItem setValue:player];
    }


}

- (void)viewWillDisappear:(BOOL)animated
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:self.usernameItem.value forKey:@"player"];
    [defaults synchronize];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
