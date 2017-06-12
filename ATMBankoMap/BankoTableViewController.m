//
//  BankoTableViewController.m
//  ATMBankoMap
//
//  Created by Admin on 12.06.17.
//  Copyright © 2017 ilya. All rights reserved.
//

#import "BankoTableViewController.h"
#import "BankoMapViewController.h"
#import "CustomAnnotation.h"
#import "BankoList.h"

@interface BankoTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *mapAnnotations;

@end

@implementation BankoTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"BankoList";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView = [UITableView new];
    CGRect bounds = self.view.bounds;
    double root_width = bounds.size.width;
    double root_hight = bounds.size.height;
    
    self.tableView.frame = CGRectMake(0, 0, root_width, root_hight);
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:self.tableView];
    
    BankoList *list = [[BankoList alloc] init];
    
    CLLocationDegrees lat = 40.731;
    CLLocationDegrees lng = -73.9906;
    
    CLLocation* location = [[CLLocation alloc] initWithLatitude:lat longitude:lng] ;
    
    __weak typeof(self) weakself = self;
    [list downloadItems:location withCompletionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.mapAnnotations = [list getAnnotations];
            [weakself.tableView reloadData];
        });
    }];
}

#pragma mark - Table view data source

-(NSInteger) tableView: (UITableView *)tableView  numberOfRowsInSection: (NSInteger)section {
    return self.mapAnnotations.count;
}

-(UITableViewCell*) tableView: (UITableView *)tableView cellForRowAtIndexPath: (NSIndexPath *)indexPath {
    UITableViewCell* cell = [UITableViewCell new];
    CustomAnnotation *item = self.mapAnnotations[indexPath.row];
    cell.textLabel.text = item.title;
    return cell;
}

-(void) tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.tabBarController.selectedIndex = 0;
    BankoMapViewController *mc = self.tabBarController.selectedViewController;
    [mc centerOn:indexPath.row];
}

@end
