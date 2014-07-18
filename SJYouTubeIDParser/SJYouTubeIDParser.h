//
//  SJYouTubeIDParser.h
//  SJYouTubeIDParser
//
//  Created by Soneé John on 7/17/14.
//  Copyright (c) 2014 AlphaSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SJYouTubeIDParser : NSObject

//http://www.youtube.com/watch?v=vsxCwsD9HoI&feature=related.
/**
 Method for retrieving the youtube ID from a youtube URL
 
 @param youtubeURL the the complete youtube video url, either youtu.be or youtube.com
 @return the YouTube ID
 
 Supported video URLs are:
 http://www.youtube.com/watch?v=sapuE9Cui0g&feature=youtu.be
 http://www.youtube.com/watch?v=sapuE9Cui0g
 youtu.be/KFPtWedl7wg_U923
 http://www.youtube.com/watch?feature=player_detailpage&v=sapuE9Cui0g_U#t=31s
 */

- (NSString *)extractYoutubeID:(NSString *)youtubeURL;
+ (instancetype) defaultParser;

/**
 *  Gets the video id from a specified video url, and calls a handler upon completion.
 */
- (void) getVideoIDWithURL:(NSString *)youtubeURL completionHandler:(void (^)(NSString *videoID, NSError *error))completionHandler;

/**
 *  Fetches video info from the specified video url, and calls a handler upon completion.
 
 */
- (void) getVideoInfoFromURL:(NSString *)youtubeURL completionHandler:(void (^)(NSString *videoID, NSString *videoTitle, NSURL *thumbnailURL, NSString *videoDescription, NSString *viewCount, long long rating,NSDate *uploaded,NSString *uploader, NSError *error))completionHandler;

@end
