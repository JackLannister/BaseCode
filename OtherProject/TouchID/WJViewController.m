//
//  WJViewController.m
//  WJTouchIDExample
//
//  Created by bringbird on 16/1/13.
//  Copyright © 2016年 韦明杰 All rights reserved.

//  QQ:6799400 Email:bringbird@163.com.


#import "WJViewController.h"
#import "WJTouchID.h"
//#import "WJAppDelegate.h"
#import "RYTLoginManager.h"
#import "UserMyModel.h"
#import "RootTool.h"
#import "AppDelegate.h"

@interface WJViewController ()<WJTouchIDDelegate>
@property (strong, nonatomic) UILabel *notice;
@property (strong, nonatomic) UIButton *touchBtn;

@end

@implementation WJViewController

- (UIButton *)touchBtn {
    if (_touchBtn==nil) {
        _touchBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _touchBtn.frame=CGRectMake(0, 0, 50, 50);
        _touchBtn.center=self.view.center;
        [_touchBtn setImage:[UIImage imageNamed:@"touchID"] forState:UIControlStateNormal];
        [_touchBtn addTarget:self action:@selector(StartWJTouchID) forControlEvents:UIControlEventTouchUpInside];
    }
    return _touchBtn;
}
- (UILabel *)notice {
    if (_notice==nil) {
        _notice=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
        _notice.center=CGPointMake(self.view.center.x, self.touchBtn.frame.origin.y+25);
        _notice.numberOfLines=2;
        _notice.textAlignment=NSTextAlignmentCenter;
    }
    return _notice;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.touchBtn];
    [self.view addSubview:self.notice];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([UIApplication sharedApplication].keyWindow.subviews.lastObject == self.view) {
            [self StartWJTouchID];
        }
    });
    
}
- (void)StartWJTouchID {
    
    [[WJTouchID touchID] startWJTouchIDWithMessage:WJNotice(@"自定义信息", @"The Custom Message") fallbackTitle:WJNotice(@"按钮标题", @"Fallback Title") delegate:self];
}
/**
 *  TouchID验证成功
 *
 *  Authentication Successul  Authorize Success
 */
- (void) WJTouchIDAuthorizeSuccess {
    _notice.text = WJNotice(@"TouchID验证成功", @"Authorize Success");
//    WJViewController *view=[WJViewController new];
//    WJAppDelegate *app = (WJAppDelegate *)[UIApplication sharedApplication].delegate;
//    app.window.rootViewController = view;
    
//    UserMyModel *model=[[UserMyModel alloc]init];
//    model.ID=@"1";
//    [[RYTLoginManager shareInstance]loginSuccess:model];
    
    [(AppDelegate *)[UIApplication sharedApplication].delegate setupTabViewController];
}

/**
 *  TouchID验证失败
 *
 *  Authentication Failure
 */
- (void) WJTouchIDAuthorizeFailure {
    _notice.text = WJNotice(@"TouchID验证失败", @"Authorize Failure");
}
/**
 *  取消TouchID验证 (用户点击了取消)
 *
 *  Authentication was canceled by user (e.g. tapped Cancel button).
 */
- (void) WJTouchIDAuthorizeErrorUserCancel {
    
    _notice.text = WJNotice(@"取消TouchID验证 (用户点击了取消)", @"Authorize Error User Cancel");
}

/**
 *  在TouchID对话框中点击输入密码按钮
 *
 *  User tapped the fallback button
 */
- (void) WJTouchIDAuthorizeErrorUserFallback {
    _notice.text = WJNotice(@"在TouchID对话框中点击输入密码按钮", @"Authorize Error User Fallback ");
}

/**
 *  在验证的TouchID的过程中被系统取消 例如突然来电话、按了Home键、锁屏...
 *
 *  Authentication was canceled by system (e.g. another application went to foreground).
 */
- (void) WJTouchIDAuthorizeErrorSystemCancel {
    _notice.text = WJNotice(@"在验证的TouchID的过程中被系统取消 ", @"Authorize Error System Cancel");
}

/**
 *  无法启用TouchID,设备没有设置密码
 *
 *  Authentication could not start, because passcode is not set on the device.
 */
- (void) WJTouchIDAuthorizeErrorPasscodeNotSet {
    _notice.text = WJNotice(@"无法启用TouchID,设备没有设置密码", @"Authorize Error Passcode Not Set");
}

/**
 *  设备没有录入TouchID,无法启用TouchID
 *
 *  Authentication could not start, because Touch ID has no enrolled fingers
 */
- (void) WJTouchIDAuthorizeErrorTouchIDNotEnrolled {
    _notice.text = WJNotice(@"设备没有录入TouchID,无法启用TouchID", @"Authorize Error TouchID Not Enrolled");
}

/**
 *  该设备的TouchID无效
 *
 *  Authentication could not start, because Touch ID is not available on the device.
 */
- (void) WJTouchIDAuthorizeErrorTouchIDNotAvailable {
    _notice.text = WJNotice(@"该设备的TouchID无效", @"Authorize Error TouchID Not Available");
}

/**
 *  多次连续使用Touch ID失败，Touch ID被锁，需要用户输入密码解锁
 *
 *  Authentication was not successful, because there were too many failed Touch ID attempts and Touch ID is now locked. Passcode is required to unlock Touch ID, e.g. evaluating LAPolicyDeviceOwnerAuthenticationWithBiometrics will ask for passcode as a prerequisite.
 *
 */
- (void) WJTouchIDAuthorizeLAErrorTouchIDLockout {
    _notice.text = WJNotice(@"多次连续使用Touch ID失败，Touch ID被锁，需要用户输入密码解锁", @"Authorize LAError TouchID Lockout");
}

/**
 *  当前软件被挂起取消了授权(如突然来了电话,应用进入前台)
 *
 *  Authentication was canceled by application (e.g. invalidate was called while authentication was inprogress).
 *
 */
- (void) WJTouchIDAuthorizeLAErrorAppCancel {
    _notice.text = WJNotice(@"当前软件被挂起取消了授权", @"Authorize LAError AppCancel");
}

/**
 *  当前软件被挂起取消了授权 (授权过程中,LAContext对象被释)
 *
 *  LAContext passed to this call has been previously invalidated.
 */
- (void) WJTouchIDAuthorizeLAErrorInvalidContext {
    _notice.text = WJNotice(@"当前软件被挂起取消了授权", @"Authorize LAError Invalid Context");
}
/**
 *  当前设备不支持指纹识别
 *
 *  The current device does not support fingerprint identification
 */
-(void)WJTouchIDIsNotSupport {
    _notice.text = WJNotice(@"当前设备不支持指纹识别", @"The Current Device Does Not Support");
}
@end
//



