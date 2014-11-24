//
//  PopupViewController.m
//  TEQWIN_PROJECT_Muay_Match
//
//  Created by Teqwin on 17/11/14.
//  Copyright (c) 2014年 Teqwin. All rights reserved.
//
#import "MBProgressHUD.h"
#import "PopupViewController.h"
#import "detail_news_ViewController.h"

@interface PopupViewController ()

@end

@implementation PopupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated {
 }
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [_golink setEnabled:NO];
    self.tabBarController.tabBar.hidden = YES;
    _loadingSpinner.hidden = NO;
    [_loadingSpinner startAnimating];
    PFQuery *query = [PFQuery queryWithClassName:@"Full_ad"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            query.cachePolicy = kPFCachePolicyNetworkElseCache ;
            NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:objects];
            r = arc4random_uniform(mutableArray.count)+1;
            RANDOM = [@(r) stringValue];
            [query whereKey:@"ad_id" equalTo:RANDOM];
        }
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                
                
                for (PFObject *object in objects) {
                    _ad_image.file = [object objectForKey:@"ad_image"];
                    
                    [_ad_image.file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                        _ad_image.image = UIGraphicsGetImageFromCurrentImageContext();
                        UIGraphicsEndImageContext();
                        _ad_image.image = [UIImage imageWithData:data];
                        _loadingSpinner.hidden = YES;
                        [_loadingSpinner stopAnimating];
                            [_golink setEnabled:YES];
                        
                    }];}}}];}];
    


  [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.teset.text =self.tattoomasterCell.name;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)button:(id)sender {

        detail_news_ViewController * mapVC = [self.storyboard instantiateViewControllerWithIdentifier:@"detail_news_ViewController"];
    [self.navigationController pushViewController:mapVC animated:YES];
    
 
    TattooMasterCell *tattoomasterCell = [[TattooMasterCell alloc] init];
    //tattoomasterCell.clickindexpath =[self.tableView indexPathForRowAtPoint:correctedPoint];
    tattoomasterCell.clickindexpath =0;
    
    tattoomasterCell.object_id = self.tattoomasterCell.object_id;
    tattoomasterCell.boxer_id = self.tattoomasterCell.boxer_id;
    tattoomasterCell.boxer_name = self.tattoomasterCell.boxer_name;
    tattoomasterCell.view = self.tattoomasterCell.view;
    tattoomasterCell.imageFile=self.tattoomasterCell.imageFile;
   
    mapVC.tattoomasterCell = tattoomasterCell;
    
   }
- (IBAction)golink:(id)sender {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Full_ad"];
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    
    [query whereKey:@"ad_id" equalTo:RANDOM];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (PFObject *object in objects) {
            
              
                NSString * ling = [object objectForKey:@"ad_link"];
              
                NSURL *url = [NSURL URLWithString:ling ];
                [[UIApplication sharedApplication] openURL:url];
               
             

             //   NSDictionary *dimensions = @{@"Full_ads":[object objectForKey:@"ad_id"]};
             //   [PFAnalytics trackEvent:@"Fullads_count" dimensions:dimensions];
                          }
            
        }    }];
    
    


    //[sender setEnabled:YES];
    
    
}

@end
