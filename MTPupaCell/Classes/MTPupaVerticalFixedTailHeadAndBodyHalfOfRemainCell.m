//
//  MTPupaVerticalFixedTailHeadAndBodyHalfOfRemainCell.m
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/29.
//

#import "MTPupaVerticalFixedTailHeadAndBodyHalfOfRemainCell.h"

@implementation MTPupaVerticalFixedTailHeadAndBodyHalfOfRemainCell

- (void)setupLayoutConstraint {
    NSInteger labelCount = [self toDealPupaShowStyle];
    if (labelCount <= 0) return;
    
    __weak typeof(self) weakSelf = self;
    
    CGFloat headTail = 0.f;
    if (!(self.style & MTPupaShowStyleNoTail)) {
        headTail = [self.labelTail realHeightInView:self.contentView];
        [self.labelTail mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.contentInsets.left);
            make.right.mas_equalTo(-weakSelf.contentInsets.right);
            make.bottom.mas_equalTo(-weakSelf.contentInsets.bottom);
            make.height.mas_equalTo(headTail);
        }];
    }
    
    // 计算Cell的内容高度
    CGFloat contentHeight = self.contentView.view_height - self.contentInsets.top - self.contentInsets.bottom;
    CGFloat height = contentHeight - headTail;
    if (labelCount > 1) {
        height -= (labelCount - 1) * self.controlHalfInterval;
        // 头身平均剩余高度，判断尾部Label是否存在，如若存在Label数量 - 1
        height = height/(labelCount - ((self.style & MTPupaShowStyleNoTail)?0:1));
    }
    
    if (!(self.style & MTPupaShowStyleNoHead)) {
        [self.labelHead mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.contentInsets.left);
            make.right.mas_equalTo(-weakSelf.contentInsets.right);
            make.top.mas_equalTo(weakSelf.contentInsets.top);
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
