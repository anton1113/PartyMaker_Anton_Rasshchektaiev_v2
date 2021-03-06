//
//  LoginScreenViewController.m
//  TestUIKit
//
//  Created by intern on 2/6/17.
//  Copyright © 2017 intern. All rights reserved.
//

#import "LoginScreenViewController.h"
#import "HTTPManager.h"

@interface LoginScreenViewController ()
@property (weak, nonatomic) IBOutlet UILabel *labelHello;
@property (weak, nonatomic) IBOutlet UILabel *labelIncorrectInput;

@property (weak, nonatomic) IBOutlet UITextField *textFieldLogin;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintContentViewTopSpace;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintContentViewBottomSpace;

@end

@implementation LoginScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpTextFieldLogin];
    [self setUpTextFieldPassword];
    
    [[PMRCoreDataManager sharedStore] deleteAllPartiesWithIDcompletion:^(BOOL success) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setUpTextFieldLogin {
    UIColor *placeHolderColor = [[UIColor alloc] initWithRed:76/266.f green:82/255.f blue:92/255.f alpha:1.f];
    self.textFieldLogin.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: placeHolderColor}];
    
    [self.textFieldLogin setReturnKeyType:UIReturnKeyDone];
}

- (void)setUpTextFieldPassword {
    UIColor *placeHolderColor = [[UIColor alloc] initWithRed:76/266.f green:82/255.f blue:92/255.f alpha:1.f];
    self.textFieldPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: placeHolderColor}];
    
    [self.textFieldPassword setReturnKeyType:UIReturnKeyDone];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    
    if (textField == self.textFieldPassword) {
        [self.constraintContentViewTopSpace setConstant:-20];
        [self.constraintContentViewBottomSpace setConstant:20];
        
        [UIView animateWithDuration:0.3f animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    if (textField == self.textFieldPassword) {
        [self.constraintContentViewTopSpace setConstant:0];
        [self.constraintContentViewBottomSpace setConstant:0];
    }
    
    [self.view endEditing:YES];
    return YES;
}

- (void)keyboardDidHide:(NSNotification*) notification {
    
}

- (void) keyboardDidShow:(NSNotification*) notification {
    
}

- (IBAction)onSignInButtonClicked:(UIButton *)sender {
    NSString *email = self.textFieldLogin.text;
    NSString *password = self.textFieldPassword.text;
    
    [[HTTPManager sharedInstance] setLoginScreenVC:self];
    [[HTTPManager sharedInstance] sendLoginRequestWithEmail:email password:password];
}

// send Get All Parties Request in case of access Login
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"SegueFromLoginScreen"]) {
        [[HTTPManager sharedInstance] sendGetAllPartiesRequest];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
