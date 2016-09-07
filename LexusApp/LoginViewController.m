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

@property (weak, nonatomic) IBOutlet UIView *selectUserView;

@property (weak, nonatomic) IBOutlet UIView *passwordView;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (assign, nonatomic) LoginViewControllerType type;

@property (strong, nonatomic) NSMutableArray *usersArr;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = LoginTypeByDefulte;
    
    self.usersArr = [NSMutableArray new];
    for (NSInteger index = 0; index < 7; index++) {
        UserModel *model = [[UserModel alloc] init];
        model.nameStr = @"zxl";
        
        [self.usersArr addObject:model];
    }
    
    NSInteger x = (CGRectGetWidth(self.view.bounds) - ((120 + 9) * self.usersArr.count - 9)) / 2.0;
    for (NSInteger index = 0; index < self.usersArr.count; index ++) {
        UserIconItemView *itemView = [[UserIconItemView alloc] initWithFrame:CGRectMake(x + index * (120 + 9), 35, 120, 143)];
        UserModel *model = [self.usersArr objectAtIndex:index];
        [itemView setupUserIconItemByUserModel:model];
        
        [self.selectUserView addSubview:itemView];
        
        __weak typeof(self) weakSelf = self;
        itemView.tapUserIconHandler = ^(UserModel * model) {
            [weakSelf selectUserViewHighlightSelectedItemByUserModel:model];
            weakSelf.type = LoginTypeBySelectUser;
        };
        
//        itemView.longPressHandler = ^() {
//            [weakSelf selectViewShakeAllItem];
//        };
    }
    
}

- (void)setType:(LoginViewControllerType)type {
    _type = type;
    
    void (^block)();
    void (^completion)(BOOL);
    switch (type) {
        case LoginTypeByDefulte:
            self.usernameView.hidden = NO;
            self.selectUserView.hidden = NO;
            self.passwordView.hidden = YES;
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
    
    [UIView animateWithDuration:0.24 animations:block completion:completion];
}

#pragma mark - 
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

//- (void)selectViewShakeAllItem {
//    for (UserIconItemView *itemView in self.selectUserView.subviews) {
//        if ([itemView isKindOfClass:[UserIconItemView class]]) {
//            [itemView shakeAnimation];
//            itemView.alpha = 1.0;
//        }
//    }
//}

#pragma mark - IBAction
- (IBAction)onTapCloseBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)onTapLoginBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([textField isEqual:self.usernameTextField]) {
        self.type = LoginTypeByUsername;
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
