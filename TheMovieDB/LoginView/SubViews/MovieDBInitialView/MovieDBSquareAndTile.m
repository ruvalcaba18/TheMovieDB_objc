//
//  MovieDBSquareAndTile.m
//  TheMovieDB
//
//  Created by The Coding Kid on 24/09/2024.
//

#import "MovieDBSquareAndTile.h"
@interface MovieDBSquareAndTile()
-(void)commonInit;
-(void)setupConstraints;
-(void)modifyContainerLayer;
@end

@implementation MovieDBSquareAndTile
@synthesize containerView;


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit {
    
    [[NSBundle mainBundle] loadNibNamed:@"MovieDBSquareAndTile" owner:self options:nil];
    [self addSubview: self.containerView];
    [self setupConstraints];
    [self modifyContainerLayer];
}

-(void)setupConstraints {
    self.containerView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *top = [containerView.topAnchor constraintEqualToAnchor:self.topAnchor];
    NSLayoutConstraint *bottom = [containerView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor];
    NSLayoutConstraint *leading = [containerView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor];
    NSLayoutConstraint *trailing = [containerView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor];
    
    top.active = YES;
    bottom.active = YES;
    leading.active = YES;
    trailing.active = YES;
}

-(void)modifyContainerLayer{
    
    self.containerView.layer.borderWidth = 5.0;
    self.containerView.layer.borderColor = [UIColor systemGreenColor].CGColor;
    self.containerView.layer.cornerRadius = 15;
    self.containerView.clipsToBounds = YES;
}
@end
