//
//  LoginViewController.m
//  LexusApp
//
//  Created by Dragonet on 16/9/5.
//  Copyright © 2016年 zxl. All rights reserved.
//

#import "LoginViewController.h"
#import "UserIconItemView.h"

typedef NS_ENUM(NSUInteger, LoginViewControllerType) {
    LoginTypeByDefulte,
    LoginTypeByUsername,
    LoginTypeBySelectUser
};

@interface LoginViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *usernameView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (weak, nonatomic) IBOutlet UIView *selectUserView;

@property (weak, nonatomic) IBOutlet UIView *passwordView;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (assign, nonatomic) LoginViewControllerType type;
@property (strong, nonatomic) NSMutableArray *usersArr;
@property (strong, nonatomic) NSString *selectedUserNameStr;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.usersArr = [LocalUserManager shareManager].localUsersArr;
    if (0 != self.usersArr.count) {
        [self setType:LoginTypeByDefulte isAnimation:NO];
        
        NSInteger x = (CGRectGetWidth(self.view.bounds) - ((120 + 9) * self.usersArr.count - 9)) / 2.0;
        for (NSInteger index = 0; index < self.usersArr.count; index ++) {
            UserIconItemView *itemView = [[UserIconItemView alloc] initWithFrame:CGRectMake(x + index * (120 + 9), 35, 120, 143)];
            UserModel *model = [self.usersArr objectAtIndex:index];
            [itemView setupUserIconItemByUserModel:model];
            
            [self.selectUserView addSubview:itemView];
            
            __weak typeof(self) weakSelf = self;
            itemView.tapUserIconHandler = ^(UserModel * model) {
                weakSelf.selectedUserNameStr = model.name;
                [weakSelf selectUserViewHighlightSelectedItemByUserModel:model];
                [weakSelf setType:LoginTypeBySelectUser isAnimation:YES];
            };
            
            itemView.longPressHandler = ^() {
                [weakSelf selectViewShakeAllItem];
            };
            
            itemView.tapUserIconDelHandler = ^(UserIconItemView *item) {
                [[LocalUserManager shareManager] removeLocalUser:item.userModel];
                [item removeFromSuperview];
                if (0 == weakSelf.usersArr.count) {
                    [self setType:LoginTypeByUsername isAnimation:NO];
                    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
                } else {
                    [self setupUserIconItemViewsFrame];
                }
            };
        }
    } else {
        [self setType:LoginTypeByUsername isAnimation:NO];
    }
}

- (void)setType:(LoginViewControllerType)type isAnimation:(BOOL)isAnimation {
    _type = type;
    
    void (^block)();
    void (^completion)(BOOL);
    switch (type) {
        case LoginTypeByDefulte:
            self.usernameView.hidden = NO;
            self.selectUserView.hidden = NO;
            self.passwordView.hidden = YES;
            block = ^() {
            };
            break;
            
        case LoginTypeByUsername:{
            self.usernameView.hidden = NO;
            self.selectUserView.hidden = YES;
            self.passwordView.hidden = NO;
            
            block = ^(){
                self.passwordView.transform = CGAffineTransformMakeTranslation(0, -196);
            };
        }
            break;
            
        case LoginTypeBySelectUser:{
            self.usernameView.hidden = YES;
            self.selectUserView.hidden = NO;
            self.passwordView.hidden = NO;
            
            block = ^(){
                self.selectUserView.transform = CGAffineTransformMakeTranslation(0, -157);
                self.passwordView.transform = CGAffineTransformMakeTranslation(0, -177);
            };
        }
            break;
        default:
            break;
    }
    
    completion = ^(BOOL isCompletion) {
        
    };
    
    if (isAnimation) {
        [UIView animateWithDuration:0.24 animations:block completion:completion];
    } else {
        block();
        completion(YES);
    }
}

#pragma mark -
- (void)setupUserIconItemViewsFrame {
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:.5 animations:^{
        NSInteger x = (CGRectGetWidth(weakSelf.view.bounds) - ((120 + 9) * weakSelf.usersArr.count - 9)) / 2.0;
        NSInteger index = 0;
        for (UserIconItemView *itemView in weakSelf.selectUserView.subviews) {
            if ([itemView isKindOfClass:[UserIconItemView class]]) {
                itemView.frame = CGRectMake(x + index * (120 + 9), 35, 120, 143);
                index ++;
            }
        }
    }];
}

- (void)selectUserViewHighlightSelectedItemByUserModel:(UserModel *)model {
    for (UserIconItemView *itemView in self.selectUserView.subviews) {
        if ([itemView isKindOfClass:[UserIconItemView class]]) {
            if ([itemView.userModel isEqual:model]) {
                itemView.alpha = 1.0;
            } else {
                itemView.alpha = .5;
            }
        }
    }
}

- (void)selectViewShakeAllItem {
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.loginBtn setTitle:@"完成编辑" forState:UIControlStateNormal];
    for (UserIconItemView *itemView in self.selectUserView.subviews) {
        if ([itemView isKindOfClass:[UserIconItemView class]]) {
            itemView.isShake = YES;
            itemView.alpha = 1.0;
        }
    }
}

#pragma mark - IBAction
- (IBAction)onTapCloseBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)onTapLoginBtn:(id)sender {
    if ([self.loginBtn.titleLabel.text isEqualToString:@"完成编辑"]) {
        [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        for (UserIconItemView *itemView in self.selectUserView.subviews) {
            if ([itemView isKindOfClass:[UserIconItemView class]]) {
                itemView.isShake = NO;
                itemView.alpha = .5;
            }
        }
    } else {
        [self.usernameTextField resignFirstResponder];
        [self.passwordTextField resignFirstResponder];
        
        NSString *name = (LoginTypeByUsername == self.type) ? self.usernameTextField.text : (LoginTypeBySelectUser == self.type) ? self.selectedUserNameStr : @"";
        
        [[NetworkingManager shareManager] networkingWithGetMethodPath:@"client/login?" params:@{@"name": name, @"password": self.passwordTextField.text} success:^(id responseObject) {
            NSString *status = [responseObject objectForKey:@"status"];
            if ([status isEqualToString:@"1"]) {
                
                NSDictionary *userInfoDic = [responseObject objectForKey:@"userinfo"];
                UserModel *userModel = [[UserModel alloc] initWithDic:userInfoDic];
                [LocalUserManager shareManager].curLoginUserModel = userModel;
                if (LoginTypeByUsername == self.type) {
                    [[LocalUserManager shareManager] AddLocalUser:userModel];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[HintView getInstance] presentMessage:@"登录成功" isAutoDismiss:YES dismissTimeInterval:1 dismissBlock:^{
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }];
                });
            } else if ([status isEqualToString:@"0"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[HintView getInstance] presentMessage:@"密码错误" isAutoDismiss:NO dismissTimeInterval:1 dismissBlock:^{
                    }];
                });
            }
        }];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([textField isEqual:self.usernameTextField]) {
        [self setType:LoginTypeByUsername isAnimation:YES];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:self.passwordTextField]) {
        [self onTapLoginBtn:nil];
    }
    
    return YES;
}

@end
