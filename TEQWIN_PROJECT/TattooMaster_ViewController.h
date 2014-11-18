//
//  TattooMaster_ViewController.h
//  TEQWIN_PROJECT
//
//  Created by Teqwin on 28/7/14.
//  Copyright (c) 2014年 Teqwin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TattooMasterCell.h"

#import <Parse/Parse.h>
#import "MTPopupWindow.h"
@interface TattooMaster_ViewController : PFQueryTableViewController <MTPopupWindowDelegate>
{
    NSArray *bannerarray;
    NSArray *imageFilesArray;
    NSMutableArray *imagesArray;
    PFObject *selectobject;
    PFObject *searchedobject;
    NSArray * count;
    NSString * like_status;
     NSString * heart_status;
    NSArray * hehe;
    PFObject * object_id;
    PFImageView *heart_statues;
    PFImageView *sex_statues;
    NSIndexPath *indexPath;
    NSArray*imageFilesArray_image;
    PFQuery * searchquery;
    PFObject *installid;
     PFQuery * boxersquery;
         NSArray * boxer_array;
    UIButton *gallary_button;
    PFImageView *gallary_image;
    NSMutableArray * newrow_array;
    NSString * RANDOM;
    int r;
    NSString * RANDOM_2;
    int r_2;
   	NSArray *questions_;
    PFObject * banobject;
    NSArray *answers_;
    int i;
    NSInteger *randomNumber_;
    PFObject *bannerobject;
    int position;
    NSArray *_quotes;
    int random;
    NSMutableArray *bannaymuarray;
    
}

- (IBAction)ADDAD:(id)sender;
- (IBAction)gobannersite:(id)sender;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedcontroller;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UISearchBar *searchbar;
- (IBAction)showsearch:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnSearch;


- (IBAction)gogallery:(id)sender;

@property (nonatomic, assign) BOOL isFav;



@property (strong,nonatomic) NSMutableArray *filteredCandyArray;

@property (strong, nonatomic) IBOutlet UITableView *table_view;

@end
