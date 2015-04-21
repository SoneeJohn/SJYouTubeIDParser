//
//  SJYouTubeIDParser.h
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

#import <Foundation/Foundation.h>
@interface SJYouTubeIDParser : NSObject

typedef NS_ENUM(NSUInteger, SJYouTubeIDParserThumbnailQuailty) {
    
    SJYouTubeIDParserThumbnailQuailtyDefault  = 1,
    
    SJYouTubeIDParserThumbnailQuailtyMedium = 2,
    
    SJYouTubeIDParserThumbnailQuailtyHigh = 3,
};
/**
 * The thumbnail quailty for the YouTube video.
 
  @b Note @b: Default value is, @b SJYouTubeIDParserThumbnailQuailtyHigh @b
 */
@property (nonatomic, assign) SJYouTubeIDParserThumbnailQuailty thumbnailQuailty;


//** The following is can example of a deleted YouTube video any attempts to fetch info about the video will result in a (404) error *//
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
 * The API Key that is required to fetch information about YouTube videos
 */
@property (nonatomic, assign) NSString *APIKey;


/**
 *  Gets the video id from a specified video url, and calls a handler upon completion.
 */
- (void) getVideoIDWithURL:(NSString *)youtubeURL completionHandler:(void (^)(NSString *videoID, NSError *error))completionHandler;

/**
 *  Fetches video info from the specified video url, and calls a handler upon completion.
 
 */
- (void) getVideoInfoFromURL:(NSString *)youtubeURL completionHandler:(void (^)(NSString *videoID, NSString *videoTitle, NSURL *thumbnailURL, NSString *videoDescription, NSString *viewCount, long long likeCount, long long dislikeCount, NSDate *uploaded,NSString *uploader, NSError *error))completionHandler;

@end
