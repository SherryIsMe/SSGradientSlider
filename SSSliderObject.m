//
//  SSSliderObject.m
//  SSGradientSlider
//
//  Created by 马清霞 on 2018/3/12.
//  Copyright © 2018年 Sherry. All rights reserved.
//

#import "SSSliderObject.h"


@interface SSSliderObject()
{
    UISlider *_currentSlider;
}
@end

@implementation SSSliderObject

- (void)beganDrawSlider{
    [self initSliderView];
}


- (void)initSliderView{
    CGRect frame = CGRectMake(_sliderX, _sliderY, _sliderWidth, 45);
    UIView *cliderLineView = [[UIView alloc]initWithFrame:frame];
    [_senderView addSubview:cliderLineView];
    CGFloat itemX = 0;
    CGFloat itemWidth = 0;
    NSUInteger count = _valueArray.count;
    for (int i = 1; i<_valueArray.count; i++) {
        NSNumber *n = _valueArray[i];
        NSString *x =  [NSString stringWithFormat:@"%.0f",n.doubleValue];
        NSNumber *value = _valueArray[count-1];
        CGFloat currentInt = x.floatValue;
        CGFloat gatherInt = value.floatValue;
        CGFloat xm =(CGFloat)currentInt/gatherInt;
        NSLog(@"xm = %f",xm);
        itemWidth =  xm*frame.size.width;
        //范围值
        UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(itemWidth-15, 0, 30, 15)];
        lb.font = [UIFont systemFontOfSize:12];
        lb.text =[NSString stringWithFormat:@"%@",_valueArray[i] ];
        lb.textColor = [UIColor grayColor];
        lb.textAlignment = NSTextAlignmentCenter;
        [cliderLineView addSubview:lb];
        
        if (i == 1) {
            UILabel *lb0 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 30, 15)];
            lb0.font = [UIFont systemFontOfSize:12];
            lb0.textColor = [UIColor grayColor];
            lb0.textAlignment = NSTextAlignmentLeft;
            lb0.text = @"0";
            [cliderLineView addSubview:lb0];
        }
        
        //线条
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(itemWidth-.25, 17, .5, 8)];
        line.backgroundColor = [UIColor grayColor];
        [cliderLineView addSubview:line];
        
        //渐变色块
        UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(itemX, 30, itemWidth-itemX, 15)];
        vi.layer.masksToBounds = YES;
        vi.backgroundColor = _colorArray[i-1];
        [cliderLineView addSubview:vi];
        itemX += itemWidth-itemX;
        if (i == 1) {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:vi.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(10, 10)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = vi.bounds;
            maskLayer.path = maskPath.CGPath;
            vi.layer.mask = maskLayer;
        }
        if (i == count-1) {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:vi.bounds byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopRight cornerRadii:CGSizeMake(10, 10)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = vi.bounds;
            maskLayer.path = maskPath.CGPath;
            vi.layer.mask = maskLayer;
        }
    }
    
    //x比上面的view小15  宽比上面的多出30
    UISlider *slider = [[UISlider alloc]initWithFrame:CGRectMake(frame.origin.x-15, frame.origin.y+frame.size.height+10, frame.size.width+30, 50)];
    slider.backgroundColor = [UIColor clearColor];
    slider.minimumTrackTintColor = [UIColor clearColor];
    slider.maximumTrackTintColor = [UIColor clearColor];
    NSNumber *valuesn = _valueArray[count-1];
    CGFloat max = valuesn.integerValue;
    slider.maximumValue = max;
    slider.minimumValue = 0;
    slider.value = 0;
    _currentSlider = slider;
    [slider setThumbImage:[self sliderThumbViewWithColor:[UIColor greenColor]text:@"0"] forState:UIControlStateNormal];
    [slider addTarget:self action:@selector(moveSlider:) forControlEvents:UIControlEventValueChanged];
    [_senderView addSubview:slider];
}


//滑块背景图片
- (UIImage *)sliderThumbViewWithColor:(UIColor *)color text:(NSString *)text{
    UIView *thumb = [[UIView alloc]initWithFrame:CGRectMake(-50, 0, 30, 60)];
    thumb.backgroundColor = [UIColor whiteColor];
    UIBezierPath *path = [[UIBezierPath alloc]init];
    [path moveToPoint:CGPointMake(15, 0)];
    [path addLineToPoint:CGPointMake(29, 20)];
    [path addLineToPoint:CGPointMake(1, 20)];
    [path addLineToPoint:CGPointMake(15, 0)];
    [path addArcWithCenter:CGPointMake(15, 23.5) radius:14 startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
    [path closePath];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = thumb.bounds;
    layer.path = path.CGPath;
    layer.fillColor = color.CGColor;
    [thumb.layer addSublayer:layer];
    //展示滑块的当前值
    UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(1, 14, 28, 20)];
    lb.text = text;
    lb.font = [UIFont systemFontOfSize:12];
    lb.textAlignment =  NSTextAlignmentCenter;
    lb.textColor =[UIColor whiteColor];
    [thumb addSubview:lb];
    //转换成图片
    UIGraphicsBeginImageContextWithOptions(thumb.bounds.size, YES, thumb.layer.contentsScale);
    [thumb.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


//移动滑块更新滑块内部数字显示
- (void)moveSlider:(UISlider *)sender{
    NSString *text = [NSString stringWithFormat:@"%.0f",sender.value];
    CGFloat updata = 0;
    for (int i = 1; i < _valueArray.count; i++) {
        NSNumber *nm = _valueArray[i];
        if (sender.value <= nm.integerValue && sender.value>updata) {
            updata =nm.integerValue;
             [_currentSlider setThumbImage:[self sliderThumbViewWithColor:_colorArray[i-1] text:text] forState:UIControlStateNormal];
        }else if (sender.value == 0){
             [_currentSlider setThumbImage:[self sliderThumbViewWithColor:_colorArray[0] text:text] forState:UIControlStateNormal];
        }
    }

    [_delegate moveSliderValue:text.floatValue];
}

@end
