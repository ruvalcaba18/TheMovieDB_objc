//
//  ViewController.h
//  TheMovieDB
//
//  Created by The Coding Kid on 24/09/2024.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)verifyCredentials:(UIButton *)sender;

@end

