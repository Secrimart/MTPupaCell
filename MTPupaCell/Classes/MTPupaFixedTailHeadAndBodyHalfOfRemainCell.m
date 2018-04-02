//
//  MTPupaFixedTailHeadAndBodyHalfOfRemainCell.m
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/29.
//

#import "MTPupaFixedTailHeadAndBodyHalfOfRemainCell.h"

@implementation MTPupaFixedTailHeadAndBodyHalfOfRemainCell

- (void)setupLayoutConstraint {
    NSInteger labelCount = [self toDealPupaShowStyle];
    if (labelCount <= 0) return;
    
    __weak typeof(self) weakSelf = self;
    CGSize tailSize = CGSizeZero;
    if (!(self.style & MTPupaShowStyleNoTail)) {
        tailSize = [self.labelTail simpleSize];
        [self.labelTail mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.contentInsets.top);
            make.right.mas_equalTo(-weakSelf.contentInsets.right);
            make.size.mas_equalTo(tailSize);
        }];
    }
    
    // 计算Cell的内容宽度
    CGFloat contentWidth = self.contentView.view_width - self.contentInsets.left - self.contentInsets.right;
    // 计算Cell的内容高度
    CGFloat contentHeight = self.contentView.view_height - self.contentInsets.top - self.contentInsets.bottom;
    
    CGFloat width = contentWidth - tailSize.width;
    if (labelCount > 1) {
        width -= (labelCount - 1) * self.controlHalfInterval;
        // 头身平均剩余宽度，判断尾部Label是否存在，如若存在Label数量 - 1
        width = width/(labelCount - ((self.style & MTPupaShowStyleNoTail)?0:1));
    }
    
    /**
     * 为了让三段文字顶端对齐，labelHead和labelBody不能与Bottom进行约束，所以需要调整lineBreakMode，根据实际字符计算高度
     * 当文本高度小于Cell的内容高度时，使用文本高度进行约束
     * 如果文本高度大于Cell的内容高度时，将文本高度设置为Cell内容高度能够显示下的最大行数的高度
     **/
    if (!(self.style & MTPupaShowStyleNoHead)) {
        NSLineBreakMode tempMode = self.labelHead.lineBreakMode;
        self.labelHead.lineBreakMode = NSLineBreakByWordWrapping;
        
        CGFloat right = self.contentInsets.right + tailSize.width + width + ((labelCount - 1)*self.controlHalfInterval);
        // 计算文本实际高度
        CGFloat headHeight = [self.labelHead realHeightInView:self.contentView atInsets:UIEdgeInsetsMake(self.contentInsets.top, self.contentInsets.left, self.contentInsets.bottom, right)];
        self.labelHead.lineBreakMode = tempMode;
        if (headHeight > contentHeight) {
            // 将文本高度设置为Cell内容高度能够显示下的最大行数的高度
            headHeight -= ceilf((headHeight - contentHeight)/self.labelHead.font.lineHeight) * self.labelHead.font.lineHeight;
        }
        
        [self.labelHead mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.contentInsets.top);
            make.height.mas_equalTo(headHeight);
            make.left.mas_equalTo(weakSelf.contentInsets.left);
            make.width.mas_equalTo(width);
        }];
    }
    
    if (!(self.style & MTPupaShowStyleNoBody)) {
        NSLineBreakMode tempMode = self.labelBody.lineBreakMode;
        self.labelBody.lineBreakMode = NSLineBreakByWordWrapping;
        
        CGFloat left = self.contentInsets.left + width + self.controlHalfInterval;
        if (self.style & MTPupaShowStyleNoHead) {
            left = self.contentInsets.left;
        }
        
        CGFloat right = self.contentInsets.right + tailSize.width + self.controlHalfInterval;
        if (self.style & MTPupaShowStyleNoTail) {
            right = self.contentInsets.right;
        }
        
        // 计算文本实际高度
        CGFloat bodyHeight = [self.labelBody realHeightInView:self.contentView atInsets:UIEdgeInsetsMake(self.contentInsets.top, left, self.contentInsets.bottom, right)];
        self.labelBody.lineBreakMode = tempMode;
        if (bodyHeight > contentHeight) {
            // 将文本高度设置为Cell内容高度能够显示下的最大行数的高度
            bodyHeight -= ceilf((bodyHeight - contentHeight)/self.labelBody.font.lineHeight) * self.labelBody.font.lineHeight;
        }
        [self.labelBody mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(weakSelf.contentInsets.top);
            make.height.mas_equalTo(bodyHeight);
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
