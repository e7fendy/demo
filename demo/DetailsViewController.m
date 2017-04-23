//
//  DetailsViewController.m
//  demo
//
//  Created by fendywu on 19/04/2017.
//  Copyright © 2017 fendywu. All rights reserved.
//

#import "DetailsViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface OtherListCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@end
@implementation OtherListCell
@end

@interface DetailsViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *otherView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelParkname;
@property (weak, nonatomic) IBOutlet UILabel *labelOpenTime;
@property (weak, nonatomic) IBOutlet UILabel *labelIntroduction;

@property (strong, nonatomic) NSArray<MyData*> *othersWithoutMe;
@end

@implementation DetailsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = self.data.Name;
    
    NSMutableArray<MyData*> *temp = [[NSMutableArray alloc] initWithArray:self.others];
    for (MyData *each in self.others) {
        if ([each._id isEqualToString:self.data._id]) {
            [temp removeObject:each];
            break;
        }
    }
    self.othersWithoutMe = temp;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:self.data.Image]];
    [self.labelName setText:self.data.Name];
    [self.labelParkname setText:self.data.ParkName];
    [self.labelIntroduction setText:self.data.Introduction];
    [self.labelOpenTime setText:self.data.OpenTime];
    
    self.otherView.hidden = (self.othersWithoutMe.count==0);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.othersWithoutMe.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyData *data = self.othersWithoutMe[indexPath.row];
    OtherListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"OtherListCell" forIndexPath:indexPath];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:data.Image]];
    [cell.label setText:data.Name];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray<MyData*> *others = self.others;
    MyData *data = self.othersWithoutMe[indexPath.row];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    DetailsViewController *dst = [storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    dst.data = data;
    dst.others = others;
    
    [self.navigationController pushViewController:dst animated:YES];
}

@end
