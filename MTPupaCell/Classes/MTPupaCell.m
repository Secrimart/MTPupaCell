//
//  MTPupaCell.m
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/28.
//

#import "MTPupaCell.h"
#import "UILabel+mtBase.h"

@implementation MTPupaCell

//MARK: - Life Cycle
- (void)initCell {
    [self.contentView addSubview:self.labelHead];
    [self.contentView addSubview:self.labelBody];
    [self.contentView addSubview:self.labelTail];
    
    self.contentInsets = UIEdgeInsetsZero;
    
    self.labelHead.lineBreakMode = NSLineBreakByTruncatingTail;
    self.labelBody.lineBreakMode = NSLineBreakByTruncatingTail;
    self.labelTail.lineBreakMode = NSLineBreakByTruncatingTail;
}

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

//MARK: - Getter And Setter
- (UILabel *)labelHead {
    if (_labelHead) return _labelHead;
    _labelHead = [[UILabel alloc] initContent];
    
    return _labelHead;
}

- (UILabel *)labelBody {
    if (_labelBody) return _labelBody;
    _labelBody = [[UILabel alloc] initContent];
    
    return _labelBody;
}

- (UILabel *)labelTail {
    if (_labelTail) return _labelTail;
    _labelTail = [[UILabel alloc] initContent];
    
    return _labelTail;
}

- (MTPupaShowStyle)style {
    MTPupaShowStyle pupa = 0;
    
    if (self.labelHead.text.length == 0) {
        pupa = pupa | MTPupaShowStyleNoHead;
    }
    
    if (self.labelBody.text.length == 0) {
        pupa = pupa | MTPupaShowStyleNoBody;
    }
    
    if (self.labelTail.text.length == 0) {
        pupa = pupa | MTPupaShowStyleNoTail;
    }
    
    return pupa;
}

- (NSInteger)toDealPupaShowStyle {
    NSInteger labelCount = 3;
    
    if ((self.style & MTPupaShowStyleNoHead) &&
        self.labelHead.superview) {
        [self.labelHead removeFromSuperview];
        labelCount --;
    } else if (!(self.style & MTPupaShowStyleNoHead) &&
               !self.labelHead.superview) {
        [self.contentView addSubview:self.labelHead];
    }
    
    if ((self.style & MTPupaShowStyleNoBody) &&
        self.labelBody.superview) {
        [self.labelBody removeFromSuperview];
        labelCount --;
    } else if (!(self.style & MTPupaShowStyleNoBody) &&
               !self.labelBody.superview) {
        [self.contentView addSubview:self.labelBody];
    }
    
    if ((self.style & MTPupaShowStyleNoTail) &&
        self.labelTail.superview) {
        [self.labelTail removeFromSuperview];
        labelCount --;
    } else if (!(self.style & MTPupaShowStyleNoTail) &&
               !self.labelTail.superview) {
        [self.contentView addSubview:self.labelTail];
    }
    
    return labelCount;
}

@end
