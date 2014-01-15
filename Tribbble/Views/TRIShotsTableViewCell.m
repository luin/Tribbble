//
//  TRIShotsTableViewCell.m
//  Tribbble
//
//  Created by Zihua Li on 1/15/14.
//  Copyright (c) 2014 Zihua Li. All rights reserved.
//

#import "TRIShotsTableViewCell.h"

@implementation TRIShotsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *wrapper = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
        [self.contentView addSubview:wrapper];
        [wrapper setBackgroundColor:[UIColor whiteColor]];
        [self.contentView setBackgroundColor:[UIColor colorWithRed:0.922 green:0.922 blue:0.922 alpha:1.0]];
        
        self.shotImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 160, 120)];
        [wrapper addSubview:self.shotImage];
        
        self.authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 123, 130, 12)];
        self.authorLabel.font =  [UIFont fontWithName:@"Helvetica-Bold" size:12];
        self.authorLabel.textAlignment = NSTextAlignmentRight;
        [wrapper addSubview:self.authorLabel];
        
        self.viewsLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 15, 130, 12)];
        self.viewsLabel.textColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
        self.viewsLabel.textAlignment = NSTextAlignmentRight;
        self.viewsLabel.font = [self.viewsLabel.font fontWithSize:12];
        [wrapper addSubview:self.viewsLabel];

        self.likesLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 32, 130, 12)];
        self.likesLabel.textColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
        self.likesLabel.textAlignment = NSTextAlignmentRight;
        self.likesLabel.font = [self.likesLabel.font fontWithSize:12];
        [wrapper addSubview:self.likesLabel];
        
        self.commentsLabel = [[UILabel alloc] initWithFrame:CGRectMake(180, 47, 130, 12)];
        self.commentsLabel.textColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
        self.commentsLabel.textAlignment = NSTextAlignmentRight;
        self.commentsLabel.font = [self.commentsLabel.font fontWithSize:12];
        [wrapper addSubview:self.commentsLabel];
        
    }
    return self;
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
