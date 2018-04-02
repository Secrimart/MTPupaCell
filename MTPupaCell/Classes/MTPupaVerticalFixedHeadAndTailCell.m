//
//  MTPupaVerticalFixedHeadAndTailCell.m
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/29.
//

#import "MTPupaVerticalFixedHeadAndTailCell.h"

@implementation MTPupaVerticalFixedHeadAndTailCell

- (void)initCell {
    [super initCell];
    
    self.labelHead.lineBreakMode = NSLineBreakByWordWrapping;
    self.labelHead.numberOfLines = 0;
    
    self.labelBody.lineBreakMode = NSLineBreakByTruncatingTail;
    self.labelBody.numberOfLines = 0;
    
    self.labelTail.lineBreakMode = NSLineBreakByWordWrapping;
    self.labelTail.numberOfLines = 0;
}

- (void)setupLayoutConstraint {
    NSInteger labelCount = [self toDealPupaShowStyle];
    if (labelCount <= 0) return;
    
    __weak typeof(self) weakSelf = self;
    if (!(self.style & MTPupaShowStyleNoHead)) {
        CGFloat headHeight = [self.labelHead realHeightInView:self.contentView];
        [self.labelHead mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.contentInsets.left);
            make.right.mas_equalTo(-weakSelf.contentInsets.right);
            make.top.mas_equalTo(weakSelf.contentInsets.top);
            make.height.mas_equalTo(headHeight);
        }];
    }
    
    if (!(self.style & MTPupaShowStyleNoTail)) {
        CGFloat tailHeight = [self.labelTail realHeightInView:self.contentView];
        [self.labelTail mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.contentInsets.left);
            make.right.mas_equalTo(-weakSelf.contentInsets.right);
            make.bottom.mas_equalTo(-weakSelf.contentInsets.bottom);
            make.height.mas_equalTo(tailHeight);
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
