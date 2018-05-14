//
//  MTPupaFixedHeadAndTailCell.h
//  MTBaseObjects
//
//  Created by Jason Li on 2018/3/29.
//

#import "MTPupaBaseCell.h"

/**
 * 三段文本Cell, 三段文本横向布局
 * 头尾按照文字内容定宽高，Bottom不进行约束
 * Body可变宽并文本截断
 *  ____________________
 * |Head |Body... |Tail |
 *  --------------------
 **/
@interface MTPupaFixedHeadAndTailCell : MTPupaBaseCell

@end
