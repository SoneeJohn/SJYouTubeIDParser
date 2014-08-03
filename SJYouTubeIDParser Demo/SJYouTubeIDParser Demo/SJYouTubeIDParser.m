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
                                       NSInteger statusCode = operation.response.statusCode;

                                       
                                       if (statusCode == 404) {
                                           //Video was deleted
                                           NSError *deletedError = [NSError errorWithDomain:@"com.AlphaSoft.SJYouTubeIDParser" code:20 userInfo:@{ NSLocalizedFailureReasonErrorKey : @"The video requested was deleted."}];

                                           completionHandler(nil, nil, nil, nil,nil, 0,nil, nil, deletedError);

                                           
                                       } else if (statusCode == 403){
                                           
                                          //The video was private
                                           NSError *privateError = [NSError errorWithDomain:@"com.AlphaSoft.SJYouTubeIDParser" code:30 userInfo:@{ NSLocalizedFailureReasonErrorKey : @"The video requested is private."}];

                                           completionHandler(nil, nil, nil, nil,nil, 0,nil, nil, privateError);
 
                                           
                                       } else{
                                          //some other error
                                           completionHandler(nil, nil, nil, nil,nil, 0,nil, nil, error);

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
        NSInteger ratingInt;
        NSString *videoIdentification = nil;
        NSString *uploader = nil;
        NSDate *uploadedDate = nil;
        completionHandler(videoIdentification, youtubeVideoTitle, thumbnailURL, videoDescription,viewCount, ratingInt,uploadedDate, uploader, error);
    }
}


#pragma Vimeo Methods

-(void)fetchVimeoInfoFromURL: (NSString *)vimeoURL completionHandler: (void (^) (NSString *title, NSString *authorName, NSString *description, NSString *thumbnail, NSString* video_id, NSError *error))completionHandler{
    
    
    //We are using Vimeo's Json API to call info on this video
    //Link to Documentation; http://developer.vimeo.com/apis/oembed
    
    //E.g of a JSON request http://vimeo.com/api/oembed.json?url=http%3A//vimeo.com/17892962
    NSError *error = NULL;

    //Dispatch to Global Queue
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)
                   , ^(void) {
                       
                       //First we need to format the URL
                       //The "%3A" characters are very important
                       NSString *unforURLString = vimeoURL;
                       NSString *baseString = @"http://vimeo.com/api/oembed.json?url=http%3A//";
                       //We have to remove the "http://"part or "https://"
                       
                       //Check to see what case we are detailing with first
                       
                       if ([unforURLString hasPrefix:@"http://"]) {
                           
                           //Remove the first 7 characters
                           unforURLString = [unforURLString substringFromIndex:7];

                       } else if ([unforURLString hasPrefix:@"https://"]){
                           //Remove the first 8 characters
                           unforURLString = [unforURLString substringFromIndex:8];
                           
                       } else if ([unforURLString rangeOfString:@".com"].location !=NSNotFound){
                           NSString *tem = [NSString stringWithFormat:@"%@%@", @"http://", vimeoURL];
                           //Remove the first 7 characters

                           unforURLString = [tem substringFromIndex:7];
                           

                           
                       }

                       
                       NSString *jsonString = [NSString stringWithFormat:@"%@%@",baseString,unforURLString];
                       
                       AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
                       [manager GET:jsonString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                           //parse out the json data
                           
                           //Get Title
                           NSArray *vimeoVideoTitleArray = [responseObject valueForKey:@"title"];
                           NSString *vimeoVideoTitle = [vimeoVideoTitleArray description];
                           
                           //Get author's name
                           NSArray *authorNameArray = [responseObject valueForKey:@"author_name"];
                           NSString *vimeoauthorName = [authorNameArray description];
                           
                           //Get description
                           NSArray *descriptionArray = [responseObject valueForKey:@"description"];
                           NSString *vimeodescription = [descriptionArray description];
                           
                           //Get thumbnail URL
                           NSArray *thumbnailurlArray = [responseObject valueForKey:@"thumbnail_url"];
                           NSString *vimeothumbnailurl = [thumbnailurlArray description];
                           
                           //Get video ID
                           
                           NSArray *videoIDArray = [responseObject valueForKey:@"video_id"];
                           NSString *videoIDString = [videoIDArray description];




                           completionHandler(vimeoVideoTitle, vimeoauthorName, vimeodescription, vimeothumbnailurl,videoIDString, error);

                       }failure:^(AFHTTPRequestOperation *operation, NSError *error) {

                           completionHandler(nil, nil, nil, nil,nil, error);

                       }];
                       
                       
                   });

    
    
}





@end
