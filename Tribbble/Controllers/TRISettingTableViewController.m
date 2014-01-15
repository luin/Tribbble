//
//  TRISettingTableViewController.m
//  Tribbble
//
//  Created by Zihua Li on 1/15/14.
//  Copyright (c) 2014 Zihua Li. All rights reserved.
//

#import "TRISettingTableViewController.h"

@interface TRISettingTableViewController ()

@end

@implementation TRISettingTableViewController

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *player = [defaults objectForKey:@"player"];
    if (player) {
        cell.textLabel.text = [NSString stringWithFormat:@"Player: %@", player];
    } else {
        cell.textLabel.text = @"Login";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Login" message:@"Enter username" delegate:self cancelButtonTitle:@"Login" otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert show];

    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%@",[[alertView textFieldAtIndex:0] text]);
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[[alertView textFieldAtIndex:0] text] forKey:@"player"];
    [defaults synchronize];
    [self.tableView reloadData];
}


@end
