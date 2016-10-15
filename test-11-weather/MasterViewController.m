//
//  MasterViewController.m
//  test-11-weather
//
//  Created by Yu Ma on 7/12/16.
//  Copyright © 2016 Yu Ma. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "DataModel.h"
#import "weatherApi.h"

@interface MasterViewController ()

@property NSMutableArray *objects;
@property (strong, nonatomic) weatherApi *weaApi;
@property (strong, nonatomic) NSArray <DataModel> *searchResults;


@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    //configue api
    self.weaApi= [[weatherApi alloc] init];
    self.searchResults = (NSArray <DataModel> *) @[];
    [self getapi];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DataModel *item = [self.searchResults objectAtIndex:indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:item];
        
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }

    DataModel *item = [self.searchResults objectAtIndex:indexPath.row];
    
    NSString *data = [NSString stringWithFormat:@"%@",item.dataTime];
    NSString *temp= [NSString stringWithFormat:@"%@",item.temp];
    NSString *coordinates = [NSString stringWithFormat:@"%@  %@  %@  %@ ", @"Tempture:", temp,@"  Main Weather:", item.weather_description];
    NSURL *imageUrl = [self returnUrl:item.weather_icon];
  
    cell.textLabel.text = data;
    cell.detailTextLabel.text = coordinates;
    cell.imageView.image = [UIImage imageNamed:@"holder"];
    
    [self.weaApi loadAsyncImageDataWithURL:imageUrl
                       andSuccessCallback:^(NSData *imageData) {
                           //TODO: save image data to cache
                           dispatch_async(dispatch_get_main_queue(), ^{
                               cell.imageView.image = [UIImage imageWithData:imageData];
                           });
                       }];

    
    
    return cell;
}


-(void)getapi{
    
    [self.weaApi getWeatherResultsWithQueryandSuccessCallback:^(NSArray<DataModel> *response){
       
        self.searchResults = response;
        //NSLog(@"rerererererere  %@", self.searchResults);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (![self.searchResults count]==0) {
                [self.tableView reloadData];
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                [self.view endEditing:YES];
            }
        });
        
        
    }andError:^(NSError *errorResponse) {
        NSLog(@"%@", errorResponse);
    }];
}

-(NSURL *)returnUrl: (NSString *)iconName{
   NSString *pngUrl = @"http://openweathermap.org/img/w/";
   NSString *urlString = [NSString stringWithFormat:@"%@%@%@", pngUrl, iconName,@".png"];
    NSURL* sss = [NSURL URLWithString:urlString];
    
    return sss;
}



@end
