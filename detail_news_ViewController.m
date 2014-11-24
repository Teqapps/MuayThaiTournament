//
//  detail_news_ViewController.m
//  TEQWIN_PROJECT
//
//  Created by Teqwin on 5/11/14.
//  Copyright (c) 2014年 Teqwin. All rights reserved.
//

#import "detail_news_ViewController.h"
#import "MBProgressHUD.h"
@interface detail_news_ViewController ()
;

@end

@implementation detail_news_ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
      self.tabBarController.tabBar.hidden = NO;
    [self queryParseMethod_boxer1];
    [self queryParseMethod];
   
    
    if (test==nil) {
        test =@"沒有簡介";
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
     self.news_detail.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];

    self.news_detail.text=test;
    self.news_detail.layer.cornerRadius=8.0f;
    self.news_detail.layer.borderWidth=2.0;
    self.news_detail.layer.borderColor =[[UIColor grayColor] CGColor];
    CGRect frame =  self.news_detail.frame;
    frame.size.height =  self.news_detail.contentSize.height;
    self.news_detail.frame = frame;
    [ self.news_detail sizeToFit];
    [self.news_detail setScrollEnabled:YES];
    
    
    
 //   [self queryParseMethod_boxer2];
       NSDictionary *dimensions = @{ @"boxer_id":self.tattoomasterCell.boxer_id    };
    [PFAnalytics trackEvent:@"show_detai_news" dimensions:dimensions];
    
    
    //  self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    self.view.backgroundColor =[UIColor blackColor];
    
    if (self.tattoomasterCell.news_view ==nil) {
        self.view_count.text = @"1";
    }
    else{
        self.view_count.text =[NSString stringWithFormat:@"%lu",(unsigned long)self.tattoomasterCell.news_view.count];
    }
   
    self.name.text =self.tattoomasterCell.boxer_name;
   // _news_detail.text=self.tattoomasterCell.boxer_id;
   // self.profile_image.file=self.tattoomasterCell.imageFile;
    //self.profile_image.layer.cornerRadius =self.profile_image.frame.size.width / 2;
    //self.profile_image.layer.borderWidth = 0.0f;
    //self.profile_image.layer.borderColor = [UIColor whiteColor].CGColor;
    //self.profile_image.clipsToBounds = YES;

}
- (void)viewWillAppear:(BOOL)animated {



      PFQuery *query = [PFQuery queryWithClassName:@"Boxers"];
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    
    //[query whereKey:@"Boxer_1_id" equalTo:self.tattoomasterCell.boxer_id];
    [query whereKey:@"boxer_id" equalTo:self.tattoomasterCell.boxer_id];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
          
            for (PFObject *object in objects) {
              _club_image.file = [object objectForKey:@"Club_image"];
                _loadingSpinner_2.hidden = NO;
                [_loadingSpinner_2 startAnimating];
                [_club_image.file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    _club_image.image = UIGraphicsGetImageFromCurrentImageContext();
                    UIGraphicsEndImageContext();
                    _club_image.image = [UIImage imageWithData:data];
                    _loadingSpinner_2.hidden = YES;
                    [_loadingSpinner_2 stopAnimating];
                
                }];
                _profile_image.file = [object objectForKey:@"Image"];
                _loadingSpinner_1.hidden = NO;
                [_loadingSpinner_1 startAnimating];
                [_profile_image.file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    _profile_image.image = UIGraphicsGetImageFromCurrentImageContext();
                    UIGraphicsEndImageContext();
                    _profile_image.image = [UIImage imageWithData:data];
                    _loadingSpinner_1.hidden = YES;
                    [_loadingSpinner_1 stopAnimating];
                    
                }];
            
            }}}];
    
}
- (void)queryParseMethod {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Boxers"];
    query.cachePolicy = kPFCachePolicyCacheElseNetwork;
    
    [query whereKey:@"boxer_id" equalTo:self.tattoomasterCell.boxer_id];
  //  [query whereKey:@"Boxer_id" equalTo:self.tattoomasterCell.boxer_id];
    boxersarray=[query findObjects];
  for (boxer_object in boxersarray) {
     test= [boxer_object objectForKey:@"Intro"];
   
    //  _club_image.image = [UIImage imageNamed:@"ICON.PNG"];
      
  }
}

       
- (void)queryParseMethod_boxer1 {

    
    PFQuery *query = [PFQuery queryWithClassName:@"Match_History"];
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
        [query orderByDescending:@"createdAt"];
    //[query whereKey:@"Boxer_1_id" equalTo:self.tattoomasterCell.boxer_id];
     [query whereKey:@"Boxer_id" equalTo:self.tattoomasterCell.boxer_id];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            imageFilesArray = [[NSArray alloc] initWithArray:objects];
            [_tableview reloadData];
           
        }
          }];
  
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [imageFilesArray count];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //lastClickedRow = indexPath.row;
    
    // selectobject = [imageFilesArray objectAtIndex:indexPath.row];
    // PFObject *imageObject = [imageFilesArray objectAtIndex:indexPath.row];
    
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"result";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    // Configure the cell
    // Configure the cell
   // PFObject *boxerobject=[boxersarray objectAtIndex:indexPath.row];
    PFObject *imageObject = [imageFilesArray objectAtIndex:indexPath.row];
  //  PFFile *thumbnail = [imageObject objectForKey:@"image"];
  //  PFImageView *thumbnailImageView = (PFImageView*)[cell viewWithTag:100];
  //  CGSize itemSize = CGSizeMake(70, 70);
 //   UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
 //   CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
 //   thumbnailImageView.layer.backgroundColor=[[UIColor clearColor] CGColor];
  //  thumbnailImageView.layer.cornerRadius=8.0f;
 //   thumbnailImageView.layer.borderWidth=0.0;
 //   thumbnailImageView.layer.masksToBounds = YES;
//    thumbnailImageView.layer.borderColor=[[UIColor whiteColor] CGColor];
//    [thumbnailImageView.image drawInRect:imageRect];
 //   thumbnailImageView.image = UIGraphicsGetImageFromCurrentImageContext();
 //   UIGraphicsEndImageContext();
    
 //   thumbnailImageView.image = [UIImage imageNamed:@"placeholder.jpg"];
    
 //   thumbnailImageView.file = thumbnail;
//[thumbnailImageView loadInBackground];
    intro.text = [imageObject objectForKey:@"Boxer_1_name"];
    UILabel*boxer_1_name = (UILabel*)[cell viewWithTag:1];
    boxer_1_name.text =self.tattoomasterCell.boxer_name;
   // UILabel *boxer_1_result = (UILabel*) [cell viewWithTag:2];
  //  boxer_1_result.text = [imageObject objectForKey:@"Boxer_results"];
    
    UILabel*boxer_2_name = (UILabel*)[cell viewWithTag:3];
    boxer_2_name.text =[imageObject objectForKey:@"Boxer_2_name"];
  //  UILabel *boxer_2_result = (UILabel*) [cell viewWithTag:4];
   // boxer_2_result.text = [imageObject objectForKey:@"Boxer_2_results"];
    UILabel *date = (UILabel*) [cell viewWithTag:5];
    date.text = [imageObject objectForKey:@"Date"];
    
    PFImageView *Match_Result_1_imageView = (PFImageView*)[cell viewWithTag:2];
    if ([[imageObject objectForKey:@"Boxer_results"]isEqualToString:@"Win"]) {
        
        Match_Result_1_imageView.image = [UIImage imageNamed:@"win.png"];
    }
    else
    {
        
        Match_Result_1_imageView.image = [UIImage imageNamed:@"lose.png"];
    }

    PFImageView *Match_Result_2_imageView = (PFImageView*)[cell viewWithTag:4];
    if ([[imageObject objectForKey:@"Boxer_2_results"]isEqualToString:@"Win"]) {
        
        Match_Result_2_imageView.image = [UIImage imageNamed:@"win.png"];
    }
    else
    {
        
        Match_Result_2_imageView.image = [UIImage imageNamed:@"lose.png"];
    }

    return cell;
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

@end
