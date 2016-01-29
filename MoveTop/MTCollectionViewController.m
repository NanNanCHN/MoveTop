//
//  CollectionViewController.m
//  MoveTop
//
//  Created by apple on 16/1/28.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import "MTCollectionViewController.h"
#import "MTCollectionViewCell.h"

#define KEY @"ORDER_KEY"
@interface MTCollectionViewController ()<MTCollectionViewCellDelegate>
@property (strong, nonatomic) NSMutableArray *orderArr;
@end

@implementation MTCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /**
     * 将顺序数组赋值
     * 本地有数据从本地取
     * 无数据创建
     */
    if ([self getOrderArrWithKey:KEY].count == 0) {
        self.orderArr = [[NSMutableArray alloc] initWithObjects:@"天气",@"股票",@"论坛", nil];
    } else {
        self.orderArr = [self getOrderArrWithKey:KEY];
    }
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
    return self.orderArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MTCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    cell.infoLabel.text = [self.orderArr objectAtIndex:indexPath.item];
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
#pragma mark MTCollectionViewCellDelegate
- (void)updateSortArrWithNum:(NSInteger)num
{
    NSString *nameStr = [self.orderArr objectAtIndex:num];
    [self.orderArr removeObjectAtIndex:num];
    [self.orderArr insertObject:nameStr atIndex:0];
    
    [self setDeFaultsWithOrderArr:self.orderArr];
    
    __weak MTCollectionViewController *wself = self;
    [self.collectionView performBatchUpdates:^{
        [wself.collectionView moveItemAtIndexPath:[NSIndexPath indexPathForItem:num inSection:0] toIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];

    } completion:^(BOOL finished) {
        if (finished) {
            [wself.collectionView reloadData];
        }
    }];
}

#pragma mark --
#pragma mark 顺序数组存到本地
- (void)setDeFaultsWithOrderArr:(NSMutableArray *)orderArr
{
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self.orderArr options:NSJSONWritingPrettyPrinted error:&error];
    NSString *order = [[NSString  alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setValue:order forKey:KEY];
    [def synchronize];
}

#pragma mark -- 
#pragma mark 从本地取出顺序数组
- (NSMutableArray *)getOrderArrWithKey:(NSString *)key
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *str = [def stringForKey:key];
    if (str == nil) {
        return nil;
    } else {
        NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        return [NSMutableArray arrayWithArray:arr];
    }
}

@end
