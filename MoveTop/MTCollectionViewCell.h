//
//  CollectionViewCell.h
//  MoveTop
//
//  Created by apple on 16/1/28.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MTCollectionViewCellDelegate <NSObject>

- (void)updateSortArrWithNum:(NSInteger)num;

@end

@interface MTCollectionViewCell : UICollectionViewCell

@property (assign, nonatomic) id<MTCollectionViewCellDelegate>delegate;
@property (assign, nonatomic) NSInteger itemNum; /// 当前第几个cell
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIButton *button;
- (IBAction)onButtonPress:(id)sender;

@end
