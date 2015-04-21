//
//  SJYouTubeIDParser.m
//  SJYouTubeIDParser
//
//  Created by Soneé John on 7/17/14.
//  Copyright (c) 2014 AlphaSoft. All rights reserved.
//

//**** License ****//
/*
 The MIT License (MIT)
 
 Copyright (c) 2014 Soneé John
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

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

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.thumbnailQuailty = 3;
    }
    return self;
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
        NSError *error = [NSError errorWithDomain:@"com.AlphaSoft.SJYouTubeIDParser" code:10 userInfo:@{ NSLocalizedFailureReasonErrorKey : @"Invalid YouTube URL" }];

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
        NSError *error = [NSError errorWithDomain:@"com.AlphaSoft.SJYouTubeIDParser" code:10 userInfo:@{ NSLocalizedFailureReasonErrorKey : @"Invalid YouTube URL" }];

        completionHandler(nil, error);

    }

}
- (void) getVideoInfoFromURL:(NSString *)youtubeURL completionHandler:(void (^)(NSString *videoID, NSString *videoTitle, NSURL *thumbnailURL, NSString *videoDescription, NSString *viewCount, long long likeCount, long long dislikeCount, NSDate *uploaded,NSString *uploader, NSError *error))completionHandler{
    
    if([self.APIKey length] >0){
        
   
   
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
                                   
                               //https://www.googleapis.com/youtube/v3/videos?part=snippet%@+statistics&id=%@&key=%@

                                   
                                   NSString *constString = @"%2C";
                                   NSString *jsonString = [NSString stringWithFormat:@"https://www.googleapis.com/youtube/v3/videos?part=snippet%@+statistics&id=%@&key=%@",constString,videoIdentification, self.APIKey];
                                   
                                   // Fetch Json info
                                    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                                   [manager GET:jsonString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                       //parse out the json data
                                       
                                       NSDictionary *dict = (NSDictionary *)responseObject;

                                       NSMutableDictionary *parseResults = [[NSMutableDictionary alloc] initWithDictionary:dict];
                                       
                                       
                                       @try {
                                          // Code that can potentially throw an exception
                                       
                                       
                                       //Get video Title
                                        NSString *youtubeVideoTitle = [[[[parseResults objectForKey:@"items"] objectAtIndex:0] objectForKey:@"snippet"] objectForKey:@"title"];
                                       
                                       
                                       //Get URL for thumbnail
                                      
                                       NSURL *thumbnailURL;
                                       if (self.thumbnailQuailty == 1) {
                                           //default
                                           thumbnailURL = [NSURL URLWithString:[[[[[[parseResults objectForKey:@"items"] objectAtIndex:0] objectForKey:@"snippet"] objectForKey:@"thumbnails"] objectForKey:@"default"]valueForKey:@"url"]];//default
                                           
                                       } else if (self.thumbnailQuailty == 2){
                                           //Medium
                                           
                                           thumbnailURL = [NSURL URLWithString:[[[[[[parseResults objectForKey:@"items"] objectAtIndex:0] objectForKey:@"snippet"] objectForKey:@"thumbnails"] objectForKey:@"medium"]valueForKey:@"url"]];//Medium
                                           
                                           
                                       } else if (self.thumbnailQuailty == 3){
                                           //High
                                           
                                           thumbnailURL = [NSURL URLWithString:[[[[[[parseResults objectForKey:@"items"] objectAtIndex:0] objectForKey:@"snippet"] objectForKey:@"thumbnails"] objectForKey:@"high"]valueForKey:@"url"]];//high
                                           
                                       } else{
                                           
                                           //Fall back to default
                                           
                                           thumbnailURL = [NSURL URLWithString:[[[[[[parseResults objectForKey:@"items"] objectAtIndex:0] objectForKey:@"snippet"] objectForKey:@"thumbnails"] objectForKey:@"default"]valueForKey:@"url"]];//default
                                           
                                       }
                                       
                                       
                                       
                                       //Get video Description
                                       NSString *videoDescription = [[[[parseResults objectForKey:@"items"] objectAtIndex:0] objectForKey:@"snippet"] objectForKey:@"description"];
                                       
                                       //Get View Count
                                       NSString *viewCount = [[[[parseResults objectForKey:@"items"] objectAtIndex:0] objectForKey:@"statistics"] objectForKey:@"viewCount"];
                                       
                                       //Get likeCount
                                       NSString *likeCount = [[[[parseResults objectForKey:@"items"] objectAtIndex:0] objectForKey:@"statistics"] objectForKey:@"likeCount"];
                                       
                                       NSInteger likeCountInt = [likeCount intValue];
                                       
                                       
                                       //Get dislikeCount
                                       NSString *dislikeCount = [[[[parseResults objectForKey:@"items"] objectAtIndex:0] objectForKey:@"statistics"] objectForKey:@"dislikeCount"];
                                       
                                       NSInteger dislikeCountInt = [dislikeCount intValue];
                                       
                                       
                                       //Get uploaded date
                                       NSDate *upld = [[[[parseResults objectForKey:@"items"] objectAtIndex:0] objectForKey:@"snippet"] objectForKey:@"publishedAt"];
                                       
                                       NSString *myDate = [[NSString stringWithFormat:@"%@", upld] substringToIndex:10];
                                       
                                       NSDateFormatter* df_utc = [[NSDateFormatter alloc] init];
                                       [df_utc setDateFormat:@"yyyy-MM-dd"];
                                       upld = [df_utc dateFromString:myDate];
                                       
                                       NSDate *uploadedDate = [df_utc dateFromString:myDate];
                                       
                                       
                                       // Get uploader
                                       NSString *uploader = [[[[parseResults objectForKey:@"items"] objectAtIndex:0] objectForKey:@"snippet"] objectForKey:@"channelTitle"];
                                       
                                       
                                       
                                       completionHandler(videoIdentification, youtubeVideoTitle, thumbnailURL, videoDescription,viewCount, likeCountInt,dislikeCountInt,uploadedDate, uploader, error);
                                       }@catch (NSException *exception) {
                                           //Handle an exception thrown in the @try block
                                           
                                           if ([parseResults objectForKey:@"items"] == nil || [[parseResults objectForKey:@"items"]count] == 0) {
                                               
                                               NSError *unavailableError = [NSError errorWithDomain:@"com.AlphaSoft.SJYouTubeIDParser" code:50 userInfo:@{ NSLocalizedFailureReasonErrorKey : @"This video is unavailable."}];
                                               
                                               completionHandler(nil, nil, nil, nil,nil, 0, 0,nil, nil, unavailableError);

                                           } else{
                                           
                                           NSError *unknownError = [NSError errorWithDomain:@"com.AlphaSoft.SJYouTubeIDParser" code:60 userInfo:@{ NSLocalizedFailureReasonErrorKey : @"An known error occurred"}];
                                           
                                           completionHandler(nil, nil, nil, nil,nil, 0, 0,nil, nil, unknownError);
                                               
                                           }

                                       }
                                       

                                       
                                      
                                   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                       //Handle error
                                       NSInteger statusCode = operation.response.statusCode;

                                       
                                       if (statusCode == 404) {
                                           //Video was deleted
                                           NSError *deletedError = [NSError errorWithDomain:@"com.AlphaSoft.SJYouTubeIDParser" code:20 userInfo:@{ NSLocalizedFailureReasonErrorKey : @"The video requested was deleted."}];

                                           completionHandler(nil, nil, nil, nil,nil, 0, 0,nil, nil, deletedError);

                                           
                                       } else if (statusCode == 403){
                                           
                                          //The video was private
                                           NSError *privateError = [NSError errorWithDomain:@"com.AlphaSoft.SJYouTubeIDParser" code:30 userInfo:@{ NSLocalizedFailureReasonErrorKey : @"The video requested is private."}];

                                           completionHandler(nil, nil, nil, nil,nil, 0,0,nil, nil, privateError);
 
                                           
                                       } else{
                                          //some other error
                                           completionHandler(nil, nil, nil, nil,nil, 0,0,nil, nil, error);

                                       }

                                       
                                   }];
                                   
                               });
        
    } else{
        // Invalid URL
        
        NSError *error = [NSError errorWithDomain:@"com.AlphaSoft.SJYouTubeIDParser" code:10 userInfo:@{ NSLocalizedFailureReasonErrorKey : @"Invalid YouTube URL" }];
        NSString *youtubeVideoTitle = nil;
        NSURL *thumbnailURL = nil;
        NSString *videoDescription = nil;
        NSString *viewCount = nil;
        NSInteger likeCountInt;
        NSInteger dislikeCountInt;

        NSString *videoIdentification = nil;
        NSString *uploader = nil;
        NSDate *uploadedDate = nil;
        completionHandler(videoIdentification, youtubeVideoTitle, thumbnailURL, videoDescription,viewCount, likeCountInt,dislikeCountInt,uploadedDate, uploader, error);
    }
    } else{
        
        NSLog(@"Please enter your YouTube API Key");
        
        NSError *error = [NSError errorWithDomain:@"com.AlphaSoft.SJYouTubeIDParser" code:40 userInfo:@{ NSLocalizedFailureReasonErrorKey : @"YouTube API Key Not Specified" }];
        NSString *youtubeVideoTitle = nil;
        NSURL *thumbnailURL = nil;
        NSString *videoDescription = nil;
        NSString *viewCount = nil;
        NSInteger likeCountInt;
        NSInteger dislikeCountInt;
        
        NSString *videoIdentification = nil;
        NSString *uploader = nil;
        NSDate *uploadedDate = nil;
        completionHandler(videoIdentification, youtubeVideoTitle, thumbnailURL, videoDescription,viewCount, likeCountInt,dislikeCountInt,uploadedDate, uploader, error);

            }

}


@end
