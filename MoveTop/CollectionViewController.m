//
//  CollectionViewController.m
//  MoveTop
//
//  Created by apple on 16/1/28.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import "CollectionViewController.h"
#import "CollectionViewCell.h"
@interface CollectionViewController ()<CollectionViewCellDelegate>
@property (strong, nonatomic) NSMutableArray *sourceArr;
@end

@implementation CollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sourceArr = [[NSMutableArray alloc] initWithObjects:@"天气",@"股票",@"论坛", nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sourceArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    cell.infoLabel.text = [self.sourceArr objectAtIndex:indexPath.item];
    cell.itemNum = indexPath.item;
    if (indexPath.item == 0) {
        cell.button.hidden = YES;
    } else {
        cell.button.hidden = NO;
    }
    // Configure the cell
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 200);
}

#pragma mark --
#pragma mark CollectionViewCellDelegate
- (void)updateSortArrWithNum:(NSInteger)num
{
    NSString *nameStr = [self.sourceArr objectAtIndex:num];
    [self.sourceArr removeObjectAtIndex:num];
    [self.sourceArr insertObject:nameStr atIndex:0];
    
    __weak CollectionViewController *wself = self;
    [self.collectionView performBatchUpdates:^{
        [wself.collectionView moveItemAtIndexPath:[NSIndexPath indexPathForItem:num inSection:0] toIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];

    } completion:^(BOOL finished) {
        if (finished) {
            [wself.collectionView reloadData];
        }
    }];
}
@end
