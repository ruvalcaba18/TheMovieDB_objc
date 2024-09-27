//
//  DetailShowViewController.m
//  TheMovieDB
//
//  Created by The Coding Kid on 26/09/2024.
//

#import "DetailShowViewController.h"

@interface DetailShowViewController ()

@end

@implementation DetailShowViewController
@synthesize selectedShow;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTranslucent:YES];
       [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
       [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
       [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}


@end
