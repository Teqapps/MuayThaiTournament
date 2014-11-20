//  TattooMaster_ViewController.m
//  TEQWIN_PROJECT
//
//  Created by Teqwin on 28/7/14.
//  Copyright (c) 2014年 Teqwin. All rights reserved.
//

#import "ImageExampleCell.h"

#import "PopupViewController.h"
#import "TattooMaster_ViewController.h"
#import "Master_Map_ViewController.h"


#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD.h"

#import <Parse/Parse.h>
#import "detail_news_ViewController.h"
@interface TattooMaster_ViewController ()<UISearchDisplayDelegate, UISearchBarDelegate>
{
    int lastClickedRow;
       UIImageView *fullImageView;
}

@property (nonatomic, strong) UISearchDisplayController *searchController;
@property (nonatomic, strong) NSMutableArray *searchResults;


@end

@implementation TattooMaster_ViewController
@synthesize searchbar;
#define TABLE_HEIGHT 80
- (id)initWithCoder:(NSCoder *)aCoder
{
    self = [super initWithCoder:aCoder];
    if (self) {
        // Custom the table
        
        // The className to query on
        self.parseClassName = @"Match";
        
        // The key of the PFObject to display in the label of the default cell style
        self.textKey = @"name";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = NO;
        
        // The number of objects to show per page
        //self.objectsPerPage = 10;
    }
    return self;
}
- (void)viewDidLoad;
{
    [super viewDidLoad];
   
    self.tabBarController.tabBar.hidden = NO;
     [self queryParseMethod_boxer1];
         CGRect newBounds = self.tableView.bounds;
    if (self.tableView.bounds.origin.y < 44) {
        newBounds.origin.y = newBounds.origin.y + self.searchbar.bounds.size.height;
        self.tableView.bounds = newBounds;
    }
    
    self.title =@"泰拳比賽";
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.jpg"]];
    self.view.backgroundColor = [UIColor blackColor];
    // searchbar.hidden = !searchbar.hidden;

    

    self.navigationController.navigationBar.translucent=NO;

    
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationItem.hidesBackButton = YES;

    //r = arc4random_uniform(3)+1;
    //RANDOM = [@(r) stringValue];
 //   NSLog(@"%d",lastClickedRow);

  
    
   
    
   
   
   
    // scroll search bar out of sight
    CGRect newBounds = self.tableView.bounds;
    if (self.tableView.bounds.origin.y < 44) {
        newBounds.origin.y = newBounds.origin.y;
        self.tableView.bounds = newBounds;
    }
    searchquery = [PFQuery queryWithClassName:@"Boxers"];
    //[query whereKey:@"Name" containsString:searchTerm];
    
    searchquery.cachePolicy=kPFCachePolicyNetworkElseCache;
    [searchquery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            boxer_array = [[NSArray alloc] initWithArray:objects];
          
        }
    }];


}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    CGRect newBounds = self.tableView.bounds;
    if (self.tableView.bounds.origin.y < 44) {
        newBounds.origin.y = newBounds.origin.y + self.searchbar.bounds.size.height;
        self.tableView.bounds = newBounds;
    }
  
}






-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.tableView) {
        
        return self.objects.count;
        
    } else {
        //NSLog(@"how many in search results");
        //NSLog(@"%@", self.searchResults.count);
        return self.searchResults.count;
        
    }

}
-(void)filterResults:(NSString *)searchTerm scope:(NSString*)scope
{
    [self.searchResults removeAllObjects];
    
    
    
    NSArray *results  = [searchquery findObjects];
    //NSLog(@"%d",results.count);
    searchquery.cachePolicy=kPFCachePolicyCacheElseNetwork;
    [self.searchResults addObjectsFromArray:results];
    
    NSPredicate *searchPredicate =
    [NSPredicate predicateWithFormat:@"Name CONTAINS[cd]%@", searchTerm];
    _searchResults = [NSMutableArray arrayWithArray:[results filteredArrayUsingPredicate:searchPredicate]];
    
    //NSLog(@"%@",_searchResults);
    // if(![scope isEqualToString:@"全部"]) {
    // Further filter the array with the scope
    //   NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"Gender contains[cd] %@", scope];
    
    //  _searchResults = [NSMutableArray arrayWithArray:[_searchResults filteredArrayUsingPredicate:resultPredicate]];
    
}//}

//當search 更新時， tableview 就會更新，無論scope select 咩
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchTerm
{
    [self filterResults :searchTerm
                   scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                          objectAtIndex:[self.searchDisplayController.searchBar
                                         selectedScopeButtonIndex]]];
    
    return YES;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    
    // Use this to allow upside down as well
    //return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}
- (void)refreshTable:(NSNotification *) notification
{
    // Reload the recipes
    [self loadObjects];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshTable" object:nil];
}

- (void)queryParseMethod_boxer1 {
    r = arc4random_uniform(3)+1;
    RANDOM = [[NSNumber numberWithInt:r] stringValue];
    r_2 = arc4random_uniform(3)+1;
    RANDOM_2 = [[NSNumber numberWithInt:r] stringValue];
    NSLog(@"%@%@",RANDOM_2,RANDOM);
    
    PFQuery *query = [PFQuery queryWithClassName:@"Banner"];
  
    query.cachePolicy = kPFCachePolicyNetworkElseCache;

 //[query whereKey:@"Boxer_id" containsString:@"3"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            {
                NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:objects];
                NSUInteger count = [mutableArray count];
                // See http://en.wikipedia.org/wiki/Fisher–Yates_shuffle
            
                    if (count > 1) {
                        for (NSUInteger i = count - 1; i > 0; --i) {
                            [mutableArray exchangeObjectAtIndex:i withObjectAtIndex:arc4random_uniform((int32_t)(i + 1))];
                        }
                    }

                
                
                bannerarray = [NSArray arrayWithArray:mutableArray];
            
    
                [_table_view reloadData];
            
              //  NSLog(@"baba%@",bannerarray);
            }
            
             //
                     //  NSLog(@"000%d",bannerarray.count);
        }
    }];
    
}





- (PFQuery *)queryForTable{



    PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
    
   
    [query whereKey:@"allow_display" equalTo:[NSNumber numberWithBool:YES]];

    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
       if ([self.objects count] == 0) {
     query.cachePolicy = kPFCachePolicyCacheThenNetwork;
       }
    
    [query orderByDescending:@"createdAt"];
   
    return query;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        if (tableView == self.tableView) {
     PFObject *imageObject = [self.objects objectAtIndex:indexPath.row];
    NSNumber * isSuccessNumber3 = (NSNumber *)[imageObject objectForKey: @"banner_allow"];
    if([isSuccessNumber3 boolValue] == YES)
    {
        return 200;
    }
    else
    {
        
       return 145;
        
    }
        }
    else
    {
        return 50;
    }
    
   
}





// Override to customize the look of a cell representing an object. The default is to display
// a UITableViewCellStyleDefault style cell with the label being the first key in the object.

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    
    static NSString *simpleTableIdentifier = @"RecipeCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:simpleTableIdentifier];
    }
    
    // Configure the cell
    // Configure the cell
   // selectobject = [boxer_array  objectAtIndex:indexPath.row];
    if (tableView == self.tableView) {
              // NSLog(@"gg%@",self.objects);
       
        UIActivityIndicatorView *loadingSpinner_2 = (UIActivityIndicatorView*) [cell viewWithTag:111];
        UIActivityIndicatorView *loadingSpinner = (UIActivityIndicatorView*) [cell viewWithTag:110];
       
        loadingSpinner.hidden= NO;
        [loadingSpinner startAnimating];
        loadingSpinner_2.hidden= NO;
        [loadingSpinner_2 startAnimating];
        PFFile *Boxer_1_image = [object objectForKey:@"Boxer_1_image"];
        PFImageView *Boxer_1_imageView = (PFImageView*)[cell viewWithTag:100];
       

        


        Boxer_1_imageView.layer.backgroundColor=[[UIColor clearColor] CGColor];
       Boxer_1_imageView.layer.cornerRadius= Boxer_1_imageView.frame.size.width / 2;
        Boxer_1_imageView.layer.borderWidth=0.1;
        Boxer_1_imageView.layer.masksToBounds = YES;
        Boxer_1_imageView.layer.borderColor=[[UIColor whiteColor] CGColor];

        Boxer_1_imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
 
        [Boxer_1_image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
            
                Boxer_1_imageView.image = [UIImage imageWithData:data];
                [loadingSpinner stopAnimating];
                loadingSpinner.hidden = YES;
               
            }}
         ];
        
        PFFile *Boxer_2_image = [object objectForKey:@"Boxer_2_image"];
        PFImageView *Boxer_2_imageView = (PFImageView*)[cell viewWithTag:99];
      
        Boxer_2_imageView.layer.backgroundColor=[[UIColor clearColor] CGColor];
        Boxer_2_imageView.layer.cornerRadius= Boxer_2_imageView.frame.size.width / 2;
        Boxer_2_imageView.layer.borderWidth=0.1;
        Boxer_2_imageView.layer.masksToBounds = YES;
        Boxer_2_imageView.layer.borderColor=[[UIColor whiteColor] CGColor];

        Boxer_2_imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();

        
        loadingSpinner_2.hidden= NO;
        [loadingSpinner_2 startAnimating];
        [Boxer_2_image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                 Boxer_2_imageView.image = [UIImage imageNamed:@"ICON.png"];
                              Boxer_2_imageView.image = [UIImage imageWithData:data];
                [loadingSpinner_2 stopAnimating];
                loadingSpinner_2.hidden = YES;
               
            }}
         ];
        
       
       // PFFile *Match_Result_1 = [object objectForKey:@"Boxer_1_resulticon"];
        NSNumber * isSuccessNumber = (NSNumber *)[object objectForKey: @"Result_allow"];
        if([isSuccessNumber boolValue] == YES)
        {

        PFImageView *Match_Result_1_imageView = (PFImageView*)[cell viewWithTag:191];
        if ([[object objectForKey:@"Boxer_1_result"]isEqualToString:@"Win"]) {
            
            
                  Match_Result_1_imageView.image = [UIImage imageNamed:@"win.png"];
               }
               else
              {
            
                   Match_Result_1_imageView.image = [UIImage imageNamed:@"lose.png"];
              }

        
        //PFFile *Match_Result_2 = [object objectForKey:@"Boxer_2_resulticon"];
        PFImageView *Match_Result_2_imageView = (PFImageView*)[cell viewWithTag:192];
        if ([[object objectForKey:@"Boxer_2_result"]isEqualToString:@"Win"]) {
            
            
            Match_Result_2_imageView.image = [UIImage imageNamed:@"win.png"];
        }
        else
            {
                
                Match_Result_2_imageView.image = [UIImage imageNamed:@"lose.png"];
            }
        }

        
         PFObject *bannerobject = [bannerarray objectAtIndex:indexPath.row  ];
     
        PFFile *banner = [bannerobject objectForKey:@"banner_image"];
      
        PFImageView *banner_imageView = (PFImageView*)[cell viewWithTag:200];
        [Boxer_1_image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
        NSNumber * isSuccessNumber3 = (NSNumber *)[object objectForKey: @"banner_allow"];
        if([isSuccessNumber3 boolValue] == YES)
        {
            banner_imageView.image = UIGraphicsGetImageFromCurrentImageContext();
       UIGraphicsEndImageContext();
          //  Boxer_1_imageView.image = [UIImage imageNamed:@"ICON.PNG"];
            banner_imageView.file = banner;
            [banner_imageView loadInBackground];
        }
        else
        {
            
            banner_imageView.hidden=YES;
            
        
        
        }

            }}];
        
        
        
        
        
        
        
        UILabel *nameLabel = (UILabel*) [cell viewWithTag:101];
        nameLabel.text = [object objectForKey:@"Boxer_1"];
        
        UILabel *nameLabel_2 = (UILabel*) [cell viewWithTag:102];
        nameLabel_2.text = [object objectForKey:@"Boxer_2"];
        //  UILabel *prepTimeLabel = (UILabel*) [cell viewWithTag:102];
        //  prepTimeLabel.text = [object objectForKey:@"address"];
        
        count=[object objectForKey:@"favorites"];
        UILabel *count_like = (UILabel*) [cell viewWithTag:105];
        count_like.text = [NSString stringWithFormat:@"%d",count.count];
        
        UILabel *match_time = (UILabel*) [cell viewWithTag:187];
        match_time.text = [object objectForKey:@"Match_Time"];
        UILabel *match_date = (UILabel*) [cell viewWithTag:188];
        match_date.text = [object objectForKey:@"Match_Date"];
        
        //   sex_statues = (PFImageView*)[cell viewWithTag:177];
        //  if ([[object objectForKey:@"gender"]isEqualToString:@"男"]) {
        
        
        //      sex_statues.image = [UIImage imageNamed:@"icon-sex-m.png"];
        //   }
        //   else
        //   if ([[object objectForKey:@"gender"]isEqualToString:@"女"]) {
        
        //      sex_statues.image = [UIImage imageNamed:@"icon-sex-f.png"];
        //  }
       
        heart_statues = (PFImageView*)[cell viewWithTag:107];
        if ([[object objectForKey:@"favorites"]containsObject:[PFUser currentUser].objectId]) {
            
            heart_statues.image = [UIImage imageNamed:@"icon-liked.png"];
        }
        else
        {
            
            heart_statues.image = [UIImage imageNamed:@"icon-like.png"];
        }
        // UICollectionView *cellImageCollection=(UICollectionView *)[cell viewWithTag:9];
        
    }
    cell.backgroundColor = [UIColor clearColor];
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        PFObject* object = self.searchResults[indexPath.row];
        
        
        cell.textLabel.text = [object objectForKey:@"Name"];
        cell.detailTextLabel.text =[object objectForKey:@"Club"];
        
    }
    

    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     lastClickedRow = indexPath.row;
    if (tableView == self.tableView) {
        
        selectobject = [self.objects  objectAtIndex:indexPath.row];
        NSLog(@"%@",[selectobject objectForKey:@"muay_id"]);
    }
    else {
        //NSLog(@"how many in search results");
        //NSLog(@"%@", self.searchResults.count);
        selectobject = [self.objects  objectAtIndex:indexPath.row];

        searchedobject = [_searchResults  objectAtIndex:indexPath.row];
        NSLog(@"%@",[selectobject objectForKey:@"boxer_id"]);
        detail_news_ViewController * mapVC = [self.storyboard instantiateViewControllerWithIdentifier:@"detail_news_ViewController"];
        [self.navigationController pushViewController:mapVC animated:YES];
        TattooMasterCell * tattoomasterCell = [[TattooMasterCell alloc] init];
        tattoomasterCell.boxer_id = [searchedobject objectForKey:@"boxer_id"];
        tattoomasterCell.boxer_name = [searchedobject objectForKey:@"Name"];
        tattoomasterCell.view = [searchedobject objectForKey:@"view"];
        tattoomasterCell.imageFile=[selectobject objectForKey:@"Boxer_2_image"];
          tattoomasterCell.imageFile=[selectobject objectForKey:@"Boxer_1_image"];
      //  tattoomasterCell.object_id = selectobject.objectId;
        
        mapVC.tattoomasterCell = tattoomasterCell;
       // NSLog(@"%@",tattoomasterCell.master_id);
    }
    
    
}


//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
// Remove the row from data model
//    PFObject *object = [self.objects objectAtIndex:indexPath.row];
//   [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//       [self refreshTable:nil];
//   }];
//}



- (IBAction)Fav:(id)sender {
    if ([PFUser currentUser]) {
        UIButton *button = sender;
        CGPoint correctedPoint =
        [button convertPoint:button.bounds.origin toView:self.tableView];
        indexPath =  [self.tableView indexPathForRowAtPoint:correctedPoint];
        lastClickedRow = indexPath.row;
        selectobject = [self.objects objectAtIndex:indexPath.row];
        
        
        if ([[selectobject objectForKey:@"favorites"]containsObject:[PFUser currentUser].objectId]) {
            
            [self dislike];
            
            NSLog(@"disliked");
            
        }
        
        else{
            
            
            [self likeImage];
            
            NSLog(@"liked");
            
        }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"尚未登入"
                                                        message:@"需要進入登入頁嗎？"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"確定",nil];
        //然后这里设定关联，此处把indexPath关联到alert上
        
        [alert show];
        
        NSLog(@"請登入");
        
        ; }
}

- (void) likeImage {
    [selectobject addUniqueObject:[PFUser currentUser].objectId forKey:@"favorites"];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Uploading";
    [hud show:YES];
    [selectobject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
        if (!error) {
            
            if ([[selectobject objectForKey:@"favorites"]containsObject:[PFUser currentUser].objectId]) {
                
            }
            [self refreshTable:nil];
            [hud hide:YES];
        }
        else {
            [self likedFail];
        }
    }];
}
- (void) dislike {
    [selectobject removeObject:[PFUser currentUser].objectId forKey:@"favorites"];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";
    [hud show:YES];
    [selectobject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            
            
            if ([[selectobject objectForKey:@"favorites"]containsObject:[PFUser currentUser].objectId]) {
                
            }
            else
            {
                
            }
            [self refreshTable:nil];
            [hud hide:YES];
        }
        else {
            [self dislikedFail];
        }
    }];
}

- (void) likedSuccess {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功!" message:@"你已經加入了我的最愛" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    
}

- (void) likedFail {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"失敗!" message:@"There was an error when liking the image" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}
- (void) dislikedSuccess {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功!" message:@"你已經取消了我的最愛" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
    
}

- (void) dislikedFail {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"失敗!" message:@"There was an error when liking the image" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"show_boxer_1"]) {
        UIButton *button = sender;
        CGPoint correctedPoint =
        [button convertPoint:button.bounds.origin toView:self.tableView];
        NSIndexPath *indexPath =  [self.tableView indexPathForRowAtPoint:correctedPoint];
        PopupViewController *destViewController = segue.destinationViewController;
        
        PFObject *object = [self.objects objectAtIndex:indexPath.row];
        TattooMasterCell *tattoomasterCell = [[TattooMasterCell alloc] init];
        
        tattoomasterCell.object_id = [object objectForKey:@"object"];
        tattoomasterCell.boxer_id = [object objectForKey:@"Boxer_1_id"];
        tattoomasterCell.imageFile=[object objectForKey:@"Boxer_1_image"];
        tattoomasterCell.boxer_name = [object objectForKey:@"Boxer_1"];
        tattoomasterCell.view = [object objectForKey:@"view"];
        tattoomasterCell.object_id = object.objectId;


        destViewController.tattoomasterCell = tattoomasterCell;
        //  NSInteger myInteger = [tattoomasterCell.view integerValue];
        //  object[@"view"] =[NSNumber numberWithFloat:(myInteger+ 1)];
        //  [object saveInBackground];
        //  NSLog(@"%@",object[@"view"]);
        //NSLog(@"%@",[object objectForKey:@"Boxer_1_id"]);
        
       // [object addUniqueObject:[PFInstallation currentInstallation].objectId forKey:@"view"];
       // [object saveInBackground];
       
        
       // MTPopupWindow *popup = [[MTPopupWindow alloc] init];
        // if (![popup superview]) {
       // popup.usesSafari = YES;
       // popup.fileName = @"info.html";
        //    [popup show];}
    }
    if ([segue.identifier isEqualToString:@"show_boxer_2"]) {
        UIButton *button = sender;
        CGPoint correctedPoint =
        [button convertPoint:button.bounds.origin toView:self.tableView];
        NSIndexPath *indexPath =  [self.tableView indexPathForRowAtPoint:correctedPoint];
        PopupViewController *destViewController = segue.destinationViewController;
        
        PFObject *object = [self.objects objectAtIndex:indexPath.row];
        TattooMasterCell *tattoomasterCell = [[TattooMasterCell alloc] init];
        //tattoomasterCell.clickindexpath =[self.tableView indexPathForRowAtPoint:correctedPoint];
        tattoomasterCell.clickindexpath =0;
        
        tattoomasterCell.object_id = [object objectForKey:@"object"];
        tattoomasterCell.boxer_id = [object objectForKey:@"Boxer_2_id"];
        tattoomasterCell.boxer_name = [object objectForKey:@"Boxer_2"];
        tattoomasterCell.view = [object objectForKey:@"view"];
        tattoomasterCell.imageFile=[object objectForKey:@"Boxer_2_image"];
        tattoomasterCell.object_id = object.objectId;

        destViewController.tattoomasterCell = tattoomasterCell;
        
        
       // NSLog(@"%@",[object objectForKey:@"Boxer_2_id"]);
      //  [object addUniqueObject:[PFInstallation currentInstallation].objectId forKey:@"view"];
      //  [object saveInBackground];
        
        
    

           }
    
    
}



- (IBAction)gogallery:(id)sender {
}

- (IBAction)showsearch:(id)sender {
         [searchbar becomeFirstResponder];
    
    

}

- (IBAction)gobannersite:(id)sender {
    UIButton *button = sender;
    CGPoint correctedPoint =
    [button convertPoint:button.bounds.origin toView:self.tableView];
    NSIndexPath *indexPath =  [self.tableView indexPathForRowAtPoint:correctedPoint];
     PFObject *object = [bannerarray objectAtIndex:indexPath.row];
    
    //NSLog(@"%@",[object objectForKey:@"banner_link"]);
    
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[object objectForKey:@"banner_link"]]];
    
    
   // NSString*bannername =  [NSString stringWithFormat:@"%@",[object objectForKey:@"banner"]];
  //  NSLog(@"%@",bannername);
   // NSLog(@"11111%@%@",[object objectForKey:@"banner_id"],[object objectForKey:@"banner_link"]);
  
    
   NSDictionary *dimensions = @{@"Banner_id":[object objectForKey:@"banner_id"]};
[PFAnalytics trackEvent:@"Banner_Count" dimensions:dimensions];
}

@end
