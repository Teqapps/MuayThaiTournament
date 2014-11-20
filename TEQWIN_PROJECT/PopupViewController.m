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

        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    [hud show:YES];

    PFQuery *query = [PFQuery queryWithClassName:@"Full_ad"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            r = arc4random_uniform(objects.count)+1;
            RANDOM = [@(r) stringValue];
    [query whereKey:@"ad_id" equalTo:RANDOM];
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            for (PFObject *object in objects) {
            
                _ad_image.file = (PFFile *)object[@"ad_image"]; // remote image
                CGSize itemSize = CGSizeMake(70, 70);
                UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
                CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
                [_ad_image.image drawInRect:imageRect];
                _ad_image.image=UIGraphicsGetImageFromCurrentImageContext();

                [_ad_image loadInBackground];
        
                     [hud hide:YES];
        
            }}}];}}];

    // NSLog(@"%@",[boxer_object objectForKey:@"Intro"]);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = YES;
  

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
    
    
    // NSLog(@"%@",[object objectForKey:@"Boxer_2_id"]);
   

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
                NSDictionary *dimensions = @{@"Full_ads":[object objectForKey:@"ad_id"]};
                [PFAnalytics trackEvent:@"Fullads_count" dimensions:dimensions];
                          }
            
        }    }];
    
    


    
    
    
}
@end
