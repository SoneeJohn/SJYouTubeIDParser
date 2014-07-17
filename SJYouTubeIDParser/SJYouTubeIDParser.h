//
//  SJYouTubeIDParser.h
//  SJYouTubeIDParser
//
//  Created by Soneé John on 7/17/14.
//  Copyright (c) 2014 AlphaSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SJYouTubeIDParser : NSObject
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

+ (NSString *)extractYoutubeID:(NSString *)youtubeURL;

@end
