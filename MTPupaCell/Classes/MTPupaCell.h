//
//  MTPupaCell.h
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/28.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MTPupaShowStyle) {
    MTPupaShowStyleNoHead = 1 << 0,
    MTPupaShowStyleNoBody = 1 << 1,
    MTPupaShowStyleNoTail = 1 << 2
};

@import MTFramework;
@import Masonry;

/**
 * 三段文本Cell, 三段文本横向布局，三等分，文本截断（初始化时定义，使用时可修改）
 *  __________________________
 * |Head... |Body... |Tail... |
 *  --------------------------
 **/

@interface MTPupaCell : UITableViewCell

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
