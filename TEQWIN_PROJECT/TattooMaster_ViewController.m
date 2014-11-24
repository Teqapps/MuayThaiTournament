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
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
          self.objectsPerPage = 4;
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

    searchquery = [PFQuery queryWithClassName:@"Boxers"];
    //[query whereKey:@"Name" containsString:searchTerm];
    
    searchquery.cachePolicy=kPFCachePolicyNetworkElseCache;
    [searchquery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            boxer_array = [[NSArray alloc] initWithArray:objects];
            
        }
    }];

    self.navigationController.navigationBar.translucent=NO;

    
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationItem.hidesBackButton = YES;

    CGRect newBounds = self.tableView.bounds;
    if (self.tableView.bounds.origin.y < 44) {
        newBounds.origin.y = newBounds.origin.y;
        self.tableView.bounds = newBounds;
    }



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
  
        return self.searchResults.count;
        
    }

}
-(void)filterResults:(NSString *)searchTerm scope:(NSString*)scope
{
    [self.searchResults removeAllObjects];
    
    
    
    NSArray *results  = [searchquery findObjects];

    searchquery.cachePolicy=kPFCachePolicyCacheElseNetwork;
    [self.searchResults addObjectsFromArray:results];
    
    NSPredicate *searchPredicate =
    [NSPredicate predicateWithFormat:@"Name CONTAINS[cd]%@", searchTerm];
    _searchResults = [NSMutableArray arrayWithArray:[results filteredArrayUsingPredicate:searchPredicate]];
    

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



- (void)queryParseMethod_boxer1 {

    
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
            
     
            }
            

        }
    }];
    
}


- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    // This method is called every time objects are loaded from Parse via the PFQuery
}
- (void)objectsWillLoad {
    [super objectsWillLoad];
    
    // This method is called before a PFQuery is fired to get more objects
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
        Boxer_1_imageView.layer.borderWidth=1;
        Boxer_1_imageView.layer.masksToBounds = YES;
        Boxer_1_imageView.layer.borderColor=[[UIColor grayColor] CGColor];

        Boxer_1_imageView.image = UIGraphicsGetImageFromCurrentImageContext();
       // UIGraphicsEndImageContext();
 
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
        Boxer_2_imageView.layer.borderWidth=1;
        Boxer_2_imageView.layer.masksToBounds = YES;
        Boxer_2_imageView.layer.borderColor=[[UIColor grayColor] CGColor];

        Boxer_2_imageView.image = UIGraphicsGetImageFromCurrentImageContext();
       // UIGraphicsEndImageContext();

        
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
         PFImageView *Match_Result_1_imageView = (PFImageView*)[cell viewWithTag:191];
       PFImageView *Match_Result_2_imageView = (PFImageView*)[cell viewWithTag:192];
       // PFFile *Match_Result_1 = [object objectForKey:@"Boxer_1_resulticon"];
        NSNumber * isSuccessNumber = (NSNumber *)[object objectForKey: @"Result_allow"];
        if([isSuccessNumber boolValue] == YES)
        {

       
        if ([[object objectForKey:@"Boxer_1_result"]isEqualToString:@"Win"]) {
            
            
                  Match_Result_1_imageView.image = [UIImage imageNamed:@"win.png"];
               }
               else  if ([[object objectForKey:@"Boxer_1_result"]isEqualToString:@"Lose"]) {
              {
            
                   Match_Result_1_imageView.image = [UIImage imageNamed:@"lose.png"];
              }
               }
               else{
                    Match_Result_1_imageView.image = nil;
               }
        //PFFile *Match_Result_2 = [object objectForKey:@"Boxer_2_resulticon"];
        
            if ([[object objectForKey:@"Boxer_2_result"]isEqualToString:@"Win"]) {
                
                
                Match_Result_2_imageView.image = [UIImage imageNamed:@"win.png"];
            }
            else  if ([[object objectForKey:@"Boxer_2_result"]isEqualToString:@"Lose"]) {
                {
                    
                    Match_Result_2_imageView.image = [UIImage imageNamed:@"lose.png"];
                }
            }
            else{
                Match_Result_2_imageView.image = nil;
            }
        }
        else
        {
            Match_Result_1_imageView.image=nil;
            Match_Result_2_imageView.image=nil;
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
       
    }
    else {
  
        selectobject = [self.objects  objectAtIndex:indexPath.row];

        searchedobject = [_searchResults  objectAtIndex:indexPath.row];
     
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


           }
    
    
}



- (IBAction)gogallery:(id)sender {
}

- (IBAction)showsearch:(id)sender {
         [searchbar becomeFirstResponder];
    
    

}

- (IBAction)gobannersite:(id)sender {
    [sender setEnabled:NO];
    UIButton *button = sender;
    CGPoint correctedPoint =
    [button convertPoint:button.bounds.origin toView:self.tableView];
    NSIndexPath *indexPath =  [self.tableView indexPathForRowAtPoint:correctedPoint];
     PFObject *object = [bannerarray objectAtIndex:indexPath.row];
       [sender setEnabled:NO];
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[object objectForKey:@"banner_link"]]];
       [sender setEnabled:YES];
  
  // NSDictionary *dimensions = @{@"Banner_id":[object objectForKey:@"banner_id"]};
//[PFAnalytics trackEvent:@"Banner_Count" dimensions:dimensions];
}

@end
