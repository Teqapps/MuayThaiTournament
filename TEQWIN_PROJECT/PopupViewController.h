//
//  PopupViewController.h
//  TEQWIN_PROJECT_Muay_Match
//
//  Created by Teqwin on 17/11/14.
//  Copyright (c) 2014年 Teqwin. All rights reserved.
//
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>
#import "TattooMasterCell.h"
@interface PopupViewController : UIViewController
{
    int r;
    NSString *RANDOM;
    NSArray * ad_array;
    PFObject *ad_object;
}
@property (nonatomic, strong) TattooMasterCell *tattoomasterCell;
@property (weak, nonatomic) IBOutlet PFImageView *ad_image;
@property (weak, nonatomic) IBOutlet UIButton *golink;
- (IBAction)golink:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingSpinner;

@property (weak, nonatomic) IBOutlet UIButton *button;
- (IBAction)button:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *teset;
@end
