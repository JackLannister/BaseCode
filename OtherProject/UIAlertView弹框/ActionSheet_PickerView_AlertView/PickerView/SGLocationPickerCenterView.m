//
//  SGLocationPickerCenterView.m
//  SGPickerView_DatePickerExample
//
//  Created by Jack on 16/9/23.
//  Copyright © 2016年 Jack. All rights reserved.
//
//

#import "SGLocationPickerCenterView.h"

@interface SGLocationPickerCenterView ()
/** 取消按钮 */
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
/** 确定按钮 */
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation SGLocationPickerCenterView

/** 取消按钮的点击事件 */
- (void)addTargetCancelBtn:(id)target action:(SEL)action {
    [self.cancelBtn addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
}

/** 确定按钮的点击事件 */
- (void)addTargetSureBtn:(id)target action:(SEL)action {
    [self.sureBtn addTarget:target action:action forControlEvents:(UIControlEventTouchUpInside)];
}


@end
