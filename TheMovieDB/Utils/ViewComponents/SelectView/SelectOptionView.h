//
//  SelectOptionView.h
//  TheMovieDB
//
//  Created by The Coding Kid on 25/09/2024.
//

#import <UIKit/UIKit.h>
#import "OptionToSearch.h"

NS_ASSUME_NONNULL_BEGIN

@interface SelectOptionView : UIView

@property (strong, nonatomic) IBOutlet UIView *containerView;
@property (strong, nonatomic) IBOutlet UIButton *moviesButton;
@property (strong, nonatomic) IBOutlet UIButton *tvShowsButton;
- (IBAction)tvShowsSelection:(UIButton *)sender;
- (IBAction)moviesSelection:(UIButton *)sender;


@end

NS_ASSUME_NONNULL_END
