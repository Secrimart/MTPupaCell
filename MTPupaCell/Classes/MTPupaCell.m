//
//  MTPupaCell.m
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/28.
//

#import "MTPupaCell.h"
#import "UILabel+mtBase.h"

@implementation MTPupaCell

//MARK: - Layout
- (void)setupLayoutConstraint {
    NSInteger labelCount = [self toDealPupaShowStyle];
    if (labelCount <= 0) return;
    
    __weak typeof(self) weakSelf = self;
    CGFloat width = ceilf((self.contentView.view_width - self.contentInsets.left - self.contentInsets.right - ((labelCount - 1)*self.controlHalfInterval))/labelCount);
    if (!(self.style & MTPupaShowStyleNoHead)) {
        [self.labelHead mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.contentInsets.top);
            make.left.mas_equalTo(weakSelf.contentInsets.left);
            make.bottom.mas_equalTo(-weakSelf.contentInsets.bottom);
            make.width.mas_equalTo(width);
        }];
    }
    
    if (!(self.style & MTPupaShowStyleNoTail)) {
        [self.labelTail mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.contentInsets.top);
            make.bottom.mas_equalTo(-weakSelf.contentInsets.bottom);
            make.right.mas_equalTo(-weakSelf.contentInsets.right);
            make.width.mas_equalTo(width);
        }];
    }
    
    if (!(self.style & MTPupaShowStyleNoBody)) {
        [self.labelBody mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.contentInsets.top);
            make.bottom.mas_equalTo(-weakSelf.contentInsets.bottom);
            if (weakSelf.style & MTPupaShowStyleNoHead) {
                make.left.mas_equalTo(weakSelf.contentInsets.left);
            } else {
                make.left.mas_equalTo(weakSelf.labelHead.mas_right).mas_offset(weakSelf.controlHalfInterval);
            }
            
            if (weakSelf.style & MTPupaShowStyleNoTail) {
                make.right.mas_equalTo(-weakSelf.contentInsets.right);
            } else {
                make.right.mas_equalTo(weakSelf.labelTail.mas_left).mas_equalTo(-weakSelf.controlHalfInterval);
            }
        }];
    }
    
}

@end
