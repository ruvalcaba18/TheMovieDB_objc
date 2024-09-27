//
//  RoundedCollectionViewCell.m
//  TheMovieDB
//
//  Created by The Coding Kid on 27/09/2024.
//

#import "RoundedCollectionViewCell.h"

@implementation RoundedCollectionViewCell
@synthesize memberPhoto,nameMemberLabel;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.memberPhoto.layer.cornerRadius = self.contentView.frame.size.width / 2;
    self.memberPhoto.layer.masksToBounds = YES;
    self.memberPhoto.layer.borderWidth = 1.0;
    self.memberPhoto.layer.borderColor = [UIColor blackColor].CGColor;
    
}


@end
