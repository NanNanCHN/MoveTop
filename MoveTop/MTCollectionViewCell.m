//
//  CollectionViewCell.m
//  MoveTop
//
//  Created by apple on 16/1/28.
//  Copyright © 2016年 Nico. All rights reserved.
//

#import "MTCollectionViewCell.h"

@implementation MTCollectionViewCell

- (IBAction)onButtonPress:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(updateSortArrWithNum:)]) {
        [self.delegate updateSortArrWithNum:self.itemNum];
    }
}
@end
