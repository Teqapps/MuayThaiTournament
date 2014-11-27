//
//  detail_news_ViewController.h
//  TEQWIN_PROJECT
//
//  Created by Teqwin on 5/11/14.
//  Copyright (c) 2014年 Teqwin. All rights reserved.
//

#import <Parse/Parse.h>
#import <UIKit/UIKit.h>
#import "TattooMasterCell.h"
@interface detail_news_ViewController : UIViewController
{
    NSArray * imageFilesArray;
    NSArray  * boxersarray;
    NSString    *test;
    PFObject *boxer_object;
    PFObject *comment;
      UITextView * intro;

}
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingSpinner_1;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingSpinner_2;
@property (weak, nonatomic) IBOutlet PFImageView *club_image;
@property (weak, nonatomic) IBOutlet UILabel *club_name;
@property (weak, nonatomic) IBOutlet UITextView *news_detail;
@property (weak, nonatomic) IBOutlet UILabel *view_count;
@property (weak, nonatomic) IBOutlet PFImageView *profile_image;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (nonatomic, strong) TattooMasterCell *tattoomasterCell;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) __block NSMutableArray *dictionaryData;
@end
