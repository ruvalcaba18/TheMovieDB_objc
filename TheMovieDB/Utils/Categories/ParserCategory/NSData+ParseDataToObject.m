//
//  NSData+ParseDataToObject.m
//  TheMovieDB
//
//  Created by The Coding Kid on 11/10/2024.
//

#import "NSData+ParseDataToObject.h"

@implementation NSData (ParseDataToObject)

+ (PostersObject *)parsePosterData:(NSData *)posterData {
    
    NSError *jsonError;
    NSDictionary *dataDicc = [NSJSONSerialization JSONObjectWithData:posterData options:0 error:&jsonError];
    
    if (jsonError) {
        
        NSLog(@"Error to decode the json : %@",jsonError.localizedDescription);
        
        return nil;
    }
    
    NSArray *postersArray = dataDicc[@"posters"];
    
    if(postersArray.count > 0 ) {
        
        NSDictionary *firstPoster = postersArray.firstObject;
        PostersObject *posterInfo = [[PostersObject alloc] init];
        posterInfo.file_path = firstPoster[@"file_path"];
        return posterInfo;
        
    }
    return nil;
}

 + (NSMutableArray *)parseTvShowData:(NSData *)data {
    
    NSError *jsonError;
    NSDictionary *jsonInformation = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
    
    if (jsonError) {
        
        NSLog(@"JSON Error: %@",jsonError.localizedDescription);
        
        return nil;
    }
    
    TvShowsModel *tvShowModel = [[TvShowsModel alloc] initModelWithPageNumber: jsonInformation[@"page"]
                                                                   totalPages: jsonInformation[@"total_pages"]
                                                                 totalResults: jsonInformation[@"total_Results"]
                                                                    andResult: jsonInformation[@"results"]];
    return [tvShowModel getResults];
}

@end
