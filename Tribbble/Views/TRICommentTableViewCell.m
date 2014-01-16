//
//  TRICommentTableViewCell.m
//  Tribbble
//
//  Created by Zihua Li on 1/16/14.
//  Copyright (c) 2014 Zihua Li. All rights reserved.
//

#import "TRICommentTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>


@implementation TRICommentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)updateComment:(NSDictionary *)comment
{
    UIImageView *avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    [avatarView setImageWithURL:[NSURL URLWithString:[[comment objectForKey:@"player"]objectForKey:@"avatar_url"]]];
    [self.contentView addSubview:avatarView];

    UILabel *authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(58, 0, 232, 20)];
    [authorLabel setText:[[comment objectForKey:@"player"]objectForKey:@"name"]];
    [authorLabel setTextColor:[UIColor colorWithRed:0.918 green:0.298 blue:0.537 alpha:1.0]];
    [self.contentView addSubview:authorLabel];

    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(58, 20, 232, 36)];
    [contentLabel setText:[comment objectForKey:@"body"]];
    contentLabel.font = [contentLabel.font fontWithSize:12];
//    contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    contentLabel.numberOfLines = 3;

    [self.contentView addSubview:contentLabel];

}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
