//
//  SSSliderObject.h
//  SSGradientSlider
//
//  Created by 马清霞 on 2018/3/12.
//  Copyright © 2018年 Sherry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol SSSliderObjectDelegate<NSObject>
@optional

- (void)moveSliderValue:(CGFloat)value;

@end

@interface SSSliderObject : NSObject


@property (nonatomic, weak) id<SSSliderObjectDelegate>delegate;

/**
 进度条颜色集合@[[UIColor Redcolor],.....] 颜色去要跟进度值对应
 */
@property (nonatomic, strong)NSArray<UIColor *> *colorArray;

/**
 进度值集合 @[@0,@10,@20,.....];
 */
@property (nonatomic, strong)NSArray <NSNumber *>* valueArray;

/**
 承载slider的视图
 */
@property (nonatomic, strong)UIView *senderView;


/**
 slider frame 目前高度是固定的
 */
@property (nonatomic)CGFloat sliderX;
@property (nonatomic)CGFloat sliderY;
@property (nonatomic)CGFloat sliderWidth;


/**
 开始绘制
 */
- (void)beganDrawSlider;


@end
