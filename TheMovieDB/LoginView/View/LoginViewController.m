//
//  ViewController.m
//  TheMovieDB
//
//  Created by The Coding Kid on 24/09/2024.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@property (atomic, strong) LoginViewModel *viewModel;
@property (atomic, strong) NSString *enteredUsername;
@property (atomic, strong ) NSString *enteredPassword;

-(void)setUpNavigation;
@end

@implementation LoginViewController
@synthesize viewModel,usernameTextField,passwordTextField,enteredUsername,enteredPassword,wallpaperView,wallpaperImage;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.viewModel = [[LoginViewModel alloc] initViewModel];
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.passwordTextField.secureTextEntry = YES;
    self.wallpaperImage.alpha = 0.5;
    [self.wallpaperView sendSubviewToBack:self.wallpaperImage];
    
    [self setUpNavigation];
}

- (void)viewDidLayoutSubviews {
    
    [super viewDidLayoutSubviews];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.wallpaperView.bounds;
    gradient.startPoint = CGPointMake(0, 0);
    gradient.endPoint = CGPointMake(1, 1);
    gradient.colors = @[(id)[UIColor systemGreenColor].CGColor, (id)[UIColor blackColor].CGColor];
    gradient.locations = @[ @0.3, @0.7 ];
    [self.wallpaperView.layer insertSublayer:gradient below:self.wallpaperImage.layer];
    
}

-(void)setUpNavigation {
    
    UINavigationBarAppearance *navAppearance = [UINavigationBarAppearance new];
    [navAppearance configureWithTransparentBackground];
    navAppearance.backgroundColor = [UIColor blackColor];
    
    NSDictionary *titleTextAttributes = @{ NSForegroundColorAttributeName: [UIColor whiteColor],
                                           NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0]
    } ;
    
    navAppearance.titleTextAttributes = titleTextAttributes;
    self.navigationItem.standardAppearance = navAppearance;
    self.navigationItem.scrollEdgeAppearance = navAppearance;
    self.navigationController.topViewController.title = LoginTitle;
    
}


- (IBAction)verifyCredentials:(UIButton *)sender {
    
    if ( [self.viewModel isUserCanLogin: self.enteredUsername withPassword: self.enteredPassword]) {
        TvShowsViewController *tvShowsController = [[TvShowsViewController alloc] init];
        [self.navigationController pushViewController:tvShowsController animated:YES];
    } else {
        // TODO : handle error
    }
    
}

#pragma mark : - UITextfield Delegate Functions

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if (textField == usernameTextField) {
        
        self.enteredUsername = textField.text;
        
    } else if (textField == passwordTextField) {
        
        self.enteredPassword = textField.text;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == usernameTextField) {
        
        self.enteredUsername = textField.text;
        
    } else if (textField == passwordTextField) {
        
        self.enteredPassword = textField.text;
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == usernameTextField) {
        
        self.enteredUsername = [self updatedTextFromTextfields:textField.text inRange:range withReplacementString:string];
    }
    
    if (textField == passwordTextField) {
        self.enteredPassword = [self updatedTextFromTextfields:textField.text inRange:range withReplacementString:string];
    }
    return YES;
}

-(NSString *) updatedTextFromTextfields:(NSString *) currentText inRange:(NSRange)range withReplacementString:(NSString *)replacementString {

    NSString *updateText = [currentText stringByReplacingCharactersInRange:range withString:replacementString];
    
    if(updateText.length > 3  ) {
       return  updateText;
    } else {
        return @"";
    }
}

@end
