//
//  LoginViewModelTests.m
//  TheMovieDBTests
//
//  Created by The Coding Kid on 26/09/2024.
//

#import <XCTest/XCTest.h>
#import "LoginViewModel.h"
#import "User.h"

@interface LoginViewModelTests : XCTestCase
@property (nonatomic, strong) LoginViewModel *viewModel;
@end

@implementation LoginViewModelTests
@synthesize viewModel;

- (void)setUp {
    [super setUp];
    
    self.viewModel = [[LoginViewModel alloc] initViewModel];
    
    User *user1 = [[User alloc] initUserWithUsername:@"codingkid" andPassword:@"coding"];
    User *user2 = [[User alloc] initUserWithUsername:@"emelgar@applaudostudios.com." andPassword:@"emelgar"];
    self.viewModel.testusers = [NSMutableArray arrayWithObjects:user1, user2, nil];
}

- (void)tearDown {
    
    self.viewModel = nil;
    [super tearDown];
}

- (void)testValidUserLogin {
    
    BOOL canLogin = [self.viewModel isUserCanLogin:@"evasquez@applaudostudios.com" withPassword:@"evasquez"];
    XCTAssertTrue(canLogin, @"User should be able to log in with correct username and password.");
    
}

- (void)testInvalidPassword {
    
    BOOL canLogin = [self.viewModel isUserCanLogin:@"testUser1" withPassword:@"wrongPassword"];
    XCTAssertFalse(canLogin, @"User should not be able to log in with incorrect password.");
    
}

- (void)testNonExistingUserLogin {
    
    BOOL canLogin = [self.viewModel isUserCanLogin:@"nonExistingUser" withPassword:@"password"];
    XCTAssertFalse(canLogin, @"Non-existing user should not be able to log in.");
    
}

- (void)testEmptyUsernameOrPassword {
    
    BOOL emptyUsernameLogin = [self.viewModel isUserCanLogin:@"" withPassword:@"password123"];
    XCTAssertFalse(emptyUsernameLogin, @"Login should fail when username is empty.");
    
    BOOL emptyPasswordLogin = [self.viewModel isUserCanLogin:@"testUser1" withPassword:@""];
    XCTAssertFalse(emptyPasswordLogin, @"Login should fail when password is empty.");
    
}




@end
