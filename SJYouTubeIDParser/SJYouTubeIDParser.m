//
//  SJYouTubeIDParser.m
//  SJYouTubeIDParser
//
//  Created by Soneé John on 7/17/14.
//  Copyright (c) 2014 AlphaSoft. All rights reserved.
//

#import "SJYouTubeIDParser.h"
#import "AFNetworking.h"
@interface SJYouTubeIDParser ()
@end

@implementation SJYouTubeIDParser
+ (instancetype) defaultParser
{
	static SJYouTubeIDParser *defaultParser;
	static dispatch_once_t once;
	dispatch_once(&once, ^{
		defaultParser = [self new];
	});
	return defaultParser;
}

- (NSString *)extractYoutubeID:(NSString *)youtubeURL
{
    NSError *error = NULL;
    
    //Create a NSRegularExpression object
    NSRegularExpression *regexExp = [NSRegularExpression regularExpressionWithPattern:@"(?<=v(=|/))([-a-zA-Z0-9_]+)|(?<=youtu.be/)([-a-zA-Z0-9_]+)" options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSRange rangeOfFirstMatch = [regexExp rangeOfFirstMatchInString:youtubeURL options:0 range:NSMakeRange(0, [youtubeURL length])];
    if(!NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0)))
    {
        //Matches
        NSString *videoIdentification = [youtubeURL substringWithRange:rangeOfFirstMatch];
        
        //Return Video ID
        return videoIdentification;
        
    } else{
        
        //Error
        NSError *error = [NSError errorWithDomain:@"Invalid YouTube URL" code:10 userInfo:nil];
        NSLog(@"SJYouTubeIDParser returned error: %@",error);
    }
    return nil;
}
- (void) getVideoIDWithURL:(NSString *)youtubeURL completionHandler:(void (^)(NSString *videoID, NSError *error))completionHandler{
    NSError *error = NULL;
    //Create a NSRegularExpression object
    NSRegularExpression *regexExp = [NSRegularExpression regularExpressionWithPattern:@"(?<=v(=|/))([-a-zA-Z0-9_]+)|(?<=youtu.be/)([-a-zA-Z0-9_]+)" options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSRange rangeOfFirstMatch = [regexExp rangeOfFirstMatchInString:youtubeURL options:0 range:NSMakeRange(0, [youtubeURL length])];
    if(!NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0)))
    {
        //Matches
        //Return Video ID
        NSString *videoIdentification = [youtubeURL substringWithRange:rangeOfFirstMatch];
        completionHandler(videoIdentification, error);
        


    } else{
        
        //Error
        NSError *error = [NSError errorWithDomain:@"Invalid YouTube URL" code:10 userInfo:nil];
        NSString *videoIdentification = nil;

        completionHandler(videoIdentification, error);

    }

}
- (void) getVideoInfoFromURL:(NSString *)youtubeURL completionHandler:(void (^)(NSString *videoID, NSString *videoTitle, NSURL *thumbnailURL, NSString *videoDescription, NSString *viewCount, long long rating, NSDate *uploaded,NSString *uploader, NSError *error))completionHandler{
    
    NSError *error = NULL;
    //Create a NSRegularExpression object
    NSRegularExpression *regexExp = [NSRegularExpression regularExpressionWithPattern:@"(?<=v(=|/))([-a-zA-Z0-9_]+)|(?<=youtu.be/)([-a-zA-Z0-9_]+)" options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSRange rangeOfFirstMatch = [regexExp rangeOfFirstMatchInString:youtubeURL options:0 range:NSMakeRange(0, [youtubeURL length])];
    
    //Found the Video ID This mean that this is a valid YouTube URL
    if(!NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0)))
    {
        
                NSString *videoIdentification = [youtubeURL substringWithRange:rangeOfFirstMatch];
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
                               , ^(void) {
                                   // Base URL to get video info on any YouTube Video:
                                   // http://gdata.youtube.com/feeds/api/videos/<Video ID HERE>?v=2&alt=jsonc
                                   
                                   //..1
                                   NSString *jsonString = [NSString stringWithFormat:@"http://gdata.youtube.com/feeds/api/videos/%@?v=2&alt=jsonc",videoIdentification];
                                   
                                   // Fetch Json info
                                    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                                   [manager GET:jsonString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                       //parse out the json data
                                       
                                       
                                       // Root JSON Array
                                       NSArray *mainJsonData = [responseObject objectForKey:@"data"];
                                       
                                       //Get video Title
                                       NSArray *youtubeVideoTitleArray = [mainJsonData valueForKey:@"title"];
                                       NSString *youtubeVideoTitle = [youtubeVideoTitleArray description];
                                       
                                       //Get URL for thumbnail
                                       NSArray *thumbnail = [mainJsonData valueForKey:@"thumbnail"];
                                       NSArray *hQTHumb = [thumbnail valueForKey:@"hqDefault"];
                                       
                                       // Get URL as string
                                       NSString *thumbnailString = [hQTHumb description];
                                       
                                       //Convert to String
                                       NSURL *thumbnailURL = [NSURL URLWithString:thumbnailString];
                                       
                                       
                                       
                                       
                                       //Get video Description
                                       NSArray *videoDescriptionArray = [mainJsonData valueForKey:@"description"];
                                       NSString *videoDescription = [videoDescriptionArray description];
                                       
                                       //Get View Count
                                       NSArray *viewCountArray = [mainJsonData valueForKey:@"viewCount"];
                                       NSString *viewCount = [viewCountArray description];
                                       
                                       //Get Rating
                                       NSArray *ratingArray = [mainJsonData valueForKey:@"rating"];
                                       NSString *rating = [ratingArray description];
                                       
                                       NSInteger ratingInt = [rating intValue];
                                       
                                       //Get uploaded date
                                       NSArray *uploadedArray = [mainJsonData valueForKey:@"uploaded"];
                                       NSString *uploaded = [uploadedArray description];
                                       //
                                       
                                       NSString *optimizatedString;
                                       optimizatedString = [uploaded substringToIndex:[uploaded length] - 14];
                                       
                                       
                                       NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                                       [dateFormat setDateFormat:@"yyyy-MM-dd"];
                                       
                                       
                                       NSString* string= optimizatedString;
                                       NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                                       [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                                       NSTimeZone *gmt = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
                                       [dateFormatter setTimeZone:gmt];
                                       
                                       NSDate *uploadedDate = [dateFormatter dateFromString:string];
                                       
                                       
                                       // Get uploader
                                       NSArray *uploaderArray = [mainJsonData valueForKey:@"uploader"];
                                       NSString *uploader = [uploaderArray description];
                                       
                                       
                                       
                                       completionHandler(videoIdentification, youtubeVideoTitle, thumbnailURL, videoDescription,viewCount, ratingInt,uploadedDate, uploader, error);
                                       
                                       
                                      
                                   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                       //Handle error
                                       NSString *youtubeVideoTitle = nil;
                                       NSURL *thumbnailURL = nil;
                                       NSString *videoDescription = nil;
                                       NSString *viewCount = nil;
                                       NSInteger ratingInt;
                                       NSString *videoIdentification = nil;
                                       NSString *uploader = nil;
                                       NSDate *uploadedDate = nil;
                                       
                                       
                                       completionHandler(videoIdentification, youtubeVideoTitle, thumbnailURL, videoDescription,viewCount, ratingInt,uploadedDate, uploader, error);

                                       
                                   }];
                                   
                               });
        
                    
        
    
        
    } else{
        
        //Invalid YouTube URL
        
        NSError *error = [NSError errorWithDomain:@"Invalid YouTube URL" code:10 userInfo:nil];
        NSString *youtubeVideoTitle = nil;
        NSURL *thumbnailURL = nil;
        NSString *videoDescription = nil;
        NSString *viewCount = nil;
        NSInteger ratingInt;
        NSString *videoIdentification = nil;
        NSString *uploader = nil;
        NSDate *uploadedDate = nil;
        completionHandler(videoIdentification, youtubeVideoTitle, thumbnailURL, videoDescription,viewCount, ratingInt,uploadedDate, uploader, error);

    }
}







@end
