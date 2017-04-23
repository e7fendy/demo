//
//  FirstViewController.m
//  demo
//
//  Created by fendywu on 18/04/2017.
//  Copyright © 2017 fendywu. All rights reserved.
//

#import "FirstViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <AFNetworking/AFURLRequestSerialization.h>
#import <AFNetworking/AFHTTPSessionManager.h>
#import "DataResult.h"
#import "DetailsViewController.h"

@interface MyCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelParkname;
@property (weak, nonatomic) IBOutlet UILabel *labelIntroduction;
@end
@implementation MyCell
@end

@interface FirstViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingView;

@property (strong, nonatomic) NSMutableDictionary<NSString*, NSMutableArray<MyData*>*> *groupedData;
@property (strong, nonatomic) NSMutableArray<NSString*> *sections;
@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MyCell" bundle:nil] forCellReuseIdentifier:@"MyCell"];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 266.f;
    
    NSString *url = @"http://data.taipei/opendata/datalist/apiAccess";
    NSDictionary *parameters = @{@"scope": @"resourceAquire",
                                 @"rid": @"bf073841-c734-49bf-a97f-3757a6013812"};
    
    self.groupedData = [NSMutableDictionary new];
    self.sections = [NSMutableArray new];
    
    __weak typeof(self) wSelf = self;
    [[AFHTTPSessionManager manager] GET:url parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [wSelf browseDone:responseObject];
        });
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Error: %@", error);
        });
    }];
}

- (void)browseDone:(id)responseObject
{
    self.loadingView.hidden = YES;
    
    DataResult *data = [[DataResult alloc] initWithDictionary:responseObject error:nil];
    
    for (MyData *each in data.result.results) {
        if ([self.groupedData objectForKey:each.ParkName] == nil) {
            self.groupedData[each.ParkName] = [NSMutableArray new];
            [self.sections addObject:each.ParkName];
        }
        
        [self.groupedData[each.ParkName] addObject:each];
    }
    
    [self.tableView reloadData];
}

#pragma mark - UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = self.sections[section];
    return self.groupedData[key].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *section = self.sections[indexPath.section];
    MyData *data = self.groupedData[section][indexPath.row];
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    
    [cell.myImageView sd_setImageWithURL:[NSURL URLWithString:data.Image]];
    [cell.labelName setText:data.Name];
    [cell.labelParkname setText:data.ParkName];
    [cell.labelIntroduction setText:data.Introduction];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 34;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.sections[section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *section = self.sections[indexPath.section];
    NSArray<MyData*> *others = self.groupedData[section];
    MyData *data = self.groupedData[section][indexPath.row];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    DetailsViewController *dst = [storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    dst.data = data;
    dst.others = others;
    
    [self.navigationController pushViewController:dst animated:YES];
}

@end
