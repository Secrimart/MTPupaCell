//
//  MTExamplePreferredCell.m
//  MTPupaCell_Example
//
//  Created by Jason Li on 2018/5/15.
//  Copyright © 2018年 rstx_reg@aliyun.com. All rights reserved.
//

#import "MTExamplePreferredCell.h"

@import MTBaseObjects;

@implementation MTExamplePreferredCell

- (void)initCell {
    [super initCell];
    
    self.labelHead.numberOfLines = 0;
    self.labelHead.lineBreakMode = NSLineBreakByWordWrapping;
    self.labelHead.textColor = [UIColor dataColor];
    self.labelHead.font = [UIFont descFont];
    
    self.labelBody.numberOfLines = 0;
    self.labelBody.lineBreakMode = NSLineBreakByWordWrapping;
    self.labelBody.textColor = [UIColor dataColor];
    self.labelBody.font = [UIFont descFont];
    
    self.labelTail.textColor = [UIColor dataColor];
    self.labelTail.font = [UIFont descFont];
    
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
}

/**
 通过MTFramework中的Category，当设置完成 contentInsets，进行一次性的布局配置。
 通过 label.preferredMaxLayoutWidth 对Label进行Height的自动适配。
 */
- (void)viewDidChangedContentInsets {
    CGFloat tailWidth = [@"8888-88-88" sizeByFont:self.labelHead.font].width;
    self.labelTail.preferredMaxLayoutWidth = tailWidth;
    
    // 计算Cell的内容宽度
    CGFloat contentWidth = CGRectGetWidth([UIScreen mainScreen].bounds) - self.contentInsets.left - self.contentInsets.right;
    CGFloat width = (contentWidth - tailWidth - self.controlHalfInterval * 2.f)/2.f;
    
    self.labelBody.preferredMaxLayoutWidth = width;
    self.labelHead.preferredMaxLayoutWidth = width;
    
    __weak typeof(self) weakSelf = self;
    [self.labelTail mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.contentInsets.top);
        make.right.mas_equalTo(-weakSelf.contentInsets.right);
        make.width.mas_equalTo(tailWidth);
        
    }];
    
    [self.labelHead mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.contentInsets.top);
        make.left.mas_equalTo(weakSelf.contentInsets.left);
        make.width.mas_equalTo(width);
        
    }];
    
    [self.labelBody mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.contentInsets.top);
        make.left.mas_equalTo(weakSelf.labelHead.mas_right).mas_offset(weakSelf.controlHalfInterval);
        make.right.mas_equalTo(weakSelf.labelTail.mas_left).mas_equalTo(-weakSelf.controlHalfInterval);
        
    }];
}

@end
