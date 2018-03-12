//
//  ViewController.m
//  SSGradientSlider
//
//  Created by 马清霞 on 2018/3/9.
//  Copyright © 2018年 Sherry. All rights reserved.
//

#import "ViewController.h"
#import "SSSliderObject.h"

@interface ViewController ()<SSSliderObjectDelegate>
{
    UISlider *_currentSlider;
    SSSliderObject *_currentObject;
}


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   SSSliderObject *object = [[SSSliderObject alloc]init];
    object.delegate = self;
    _currentObject = object;
    object.sliderX = 20;
    object.sliderY = 100;
    object.sliderWidth = 360;
    object.colorArray = @[[UIColor greenColor],[UIColor yellowColor], [UIColor orangeColor], [UIColor redColor],[UIColor purpleColor],[UIColor brownColor]];
    object.valueArray = @[@0,@50,@100,@150,@200,@300,@500];
    object.senderView = self.view;
    [object beganDrawSlider];
}

#pragma mark - SSSliderObjectDelegate
- (void)moveSliderValue:(CGFloat)value{
    NSLog(@"---%f",value);
}
@end
