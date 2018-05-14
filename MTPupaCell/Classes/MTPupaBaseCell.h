//
//  MTPupaBaseCell.h
//  MTPupaCell
//
//  Created by Jason Li on 2018/5/14.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MTPupaShowStyle) {
    MTPupaShowStyleNoHead = 1 << 0,
    MTPupaShowStyleNoBody = 1 << 1,
    MTPupaShowStyleNoTail = 1 << 2
};

@import MTFramework;
@import Masonry;

@interface MTPupaBaseCell : UITableViewCell

@property (nonatomic, readonly) MTPupaShowStyle style; // 使用头身尾的设置，通过label的Text程度进行判断

/**
 调用该方法根于Label的text进行Label的显示和隐藏处理
 
 @return 显示的Label个数
 */
- (NSInteger)toDealPupaShowStyle;

@property (nonatomic, strong) UILabel *labelHead; // 虫头

@property (nonatomic, strong) UILabel *labelBody; // 虫身

@property (nonatomic, strong) UILabel *labelTail; // 虫尾

@end
