//
//  TRIShotDetailViewController.h
//  Tribbble
//
//  Created by Zihua Li on 1/15/14.
//  Copyright (c) 2014 Zihua Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRIShotDetailViewController : UIViewController
@property (nonatomic, retain) NSNumber *shotId;
@property (nonatomic, retain) UIImage *placeholderImage;
@property (nonatomic, retain) NSString *placeholderTitle;
@property (nonatomic, retain) NSURL *imageURL;
@end
