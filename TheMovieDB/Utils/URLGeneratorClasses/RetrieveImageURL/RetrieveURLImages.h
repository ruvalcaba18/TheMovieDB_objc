//
//  RetrieveURLImages.h
//  TheMovieDB
//
//  Created by The Coding Kid on 22/10/2024.
//

#import <Foundation/Foundation.h>
#import "URLFactory.h"
#import "Constants.h"
#import "OptionToSearch.h"

NS_ASSUME_NONNULL_BEGIN

@interface RetrieveURLImages : NSObject<URLFactory>
-(instancetype)initImagesURL;
@end

NS_ASSUME_NONNULL_END
