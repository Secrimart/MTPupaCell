//
//  MTPupaVerticalCell.m
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/29.
//

#import "MTPupaVerticalCell.h"

@implementation MTPupaVerticalCell

//MARK: - Layout
- (void)setupLayoutConstraint {
    NSInteger labelCount = [self toDealPupaShowStyle];
    if (labelCount <= 0) return;
    
    __weak typeof(self) weakSelf = self;
    
    CGFloat height = ceilf((self.contentView.view_height - self.contentInsets.top - self.contentInsets.bottom - ((labelCount - 1)*weakSelf.controlHalfInterval))/labelCount);
    
    if (!(self.style & MTPupaShowStyleNoHead)) {
        [self.labelHead mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.contentInsets.top);
            make.left.mas_equalTo(weakSelf.contentInsets.left);
            make.right.mas_equalTo(-weakSelf.contentInsets.right);
            make.height.mas_equalTo(height);
        }];
    }
    
    if (!(self.style & MTPupaShowStyleNoTail)) {
        [self.labelTail mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.contentInsets.left);
            make.right.mas_equalTo(-weakSelf.contentInsets.right);
            make.bottom.mas_equalTo(-weakSelf.contentInsets.bottom);
            make.height.mas_equalTo(height);
        }];
    }
    
    if (!(self.style & MTPupaShowStyleNoBody)) {
        [self.labelBody mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.contentInsets.left);
            make.right.mas_equalTo(-weakSelf.contentInsets.right);
            if (self.style & MTPupaShowStyleNoHead) {
                make.top.mas_equalTo(weakSelf.contentInsets.top);
            } else {
                make.top.mas_equalTo(weakSelf.labelHead.mas_bottom).mas_offset(weakSelf.controlHalfInterval);
            }
            if (self.style & MTPupaShowStyleNoTail) {
                make.bottom.mas_equalTo(-weakSelf.contentInsets.bottom);
            } else {
                make.bottom.mas_equalTo(weakSelf.labelTail.mas_top).mas_offset(-weakSelf.controlHalfInterval);
            }
        }];
    }
    
}

@end
