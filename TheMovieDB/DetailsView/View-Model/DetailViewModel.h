//
//  DetailViewModel.h
//  TheMovieDB
//
//  Created by The Coding Kid on 26/09/2024.
//

#import <Foundation/Foundation.h>
#import "OptiontoSearch.h"
#import "Constants.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *showDetails;

-(instancetype)initDetailViewModel;
-(void)fetchDetailsWithOption:(OptionToSearch)option andIdentifier:(NSString *)identifier ;

@end

NS_ASSUME_NONNULL_END
