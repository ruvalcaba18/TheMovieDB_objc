//
//  ViewController.m
//  TheMovieDB
//
//  Created by The Coding Kid on 24/09/2024.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (atomic, strong) LoginViewModel *viewModel;
@property (atomic, strong) NSString *userTapped;
@property (atomic, strong ) NSString *passwordTapped;

-(void)setUpNavigation;
@end

@implementation LoginViewController
@synthesize viewModel,usernameTextField,passwordTextField,userTapped,passwordTapped,wallpaperView,wallpaperImage;

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
    
    if ( [self.viewModel isUserCanLogin: self.userTapped withPassword: self.passwordTapped]) {
        TvShowsViewController *tvShowsController = [[TvShowsViewController alloc] init];
        [self.navigationController pushViewController:tvShowsController animated:YES];
    } else {
        // TODO : hacer pantalla de error 
    }
    
}

#pragma mark : - UITextfield Delegate Functions
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField == usernameTextField) {
        self.userTapped = textField.text;
    } else if (textField == passwordTextField) {
        self.passwordTapped = textField.text;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == usernameTextField) {
        self.userTapped = textField.text;
    } else if (textField == passwordTextField) {
        self.passwordTapped = textField.text;
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == usernameTextField) {
        NSString *currentText = textField.text;
        NSString *updateText = [currentText stringByReplacingCharactersInRange:range withString:string];
        
        if(updateText.length > 3  ) {
            self.userTapped = updateText;
        }
        
    }
    
    if (textField == passwordTextField) {
        NSString *currentText = textField.text;
        NSString *updateText = [currentText stringByReplacingCharactersInRange:range withString:string];
        
        if(updateText.length > 3  ) {
            self.passwordTapped = updateText;
        }
        
    }
    return YES;
}
@end
