//
//  ViewController.h
//  TheMovieDB
//
//  Created by The Coding Kid on 24/09/2024.
//

#import <UIKit/UIKit.h>
#import "LoginViewModel.h"
#import "TvShowsViewController.h"
@interface LoginViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)verifyCredentials:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIView *wallpaperView;
@property (strong, nonatomic) IBOutlet UIImageView *wallpaperImage;

@end

