//
//  RoundedCollectionViewCell.h
//  TheMovieDB
//
//  Created by The Coding Kid on 27/09/2024.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RoundedCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIView *roundedContentView;
@property (strong, nonatomic) IBOutlet UILabel *nameMemberLabel;
@property (strong, nonatomic) IBOutlet UIImageView *memberPhoto;

@end

NS_ASSUME_NONNULL_END
