//
//  TRIShotsCollectionViewCell.m
//  Tribbble
//
//  Created by Zihua Li on 1/15/14.
//  Copyright (c) 2014 Zihua Li. All rights reserved.
//

#import "TRIShotsCollectionViewCell.h"

@implementation TRIShotsCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        self.shotImage = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:self.shotImage];

    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
