//
//  SelectOptionView.m
//  TheMovieDB
//
//  Created by The Coding Kid on 25/09/2024.
//

#import "SelectOptionView.h"

@interface SelectOptionView()
-(void)commonInit;
-(void)setupConstraints ;
@end

@implementation SelectOptionView
@synthesize containerView;

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit {
    
    [[NSBundle mainBundle ] loadNibNamed:@"SelectOptionView" owner:self options:nil];
    [self addSubview:self.containerView];
    
}

-(void)setupConstraints {
    self.containerView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *top = [self.containerView.topAnchor constraintEqualToAnchor:self.topAnchor];
    NSLayoutConstraint *bottom = [self.containerView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor];
    NSLayoutConstraint *leading = [self.containerView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor];
    NSLayoutConstraint *trailing = [self.containerView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor];
    
    top.active = YES;
    bottom.active = YES;
    leading.active = YES;
    trailing.active = YES;
}
@end
