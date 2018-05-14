//
//  MTPupaBaseCell.m
//  MTPupaCell
//
//  Created by Jason Li on 2018/5/14.
//

#import "MTPupaBaseCell.h"
#import "UILabel+mtBase.h"

@implementation MTPupaBaseCell

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
