//
//  SJYouTubeIDParser.m
//  SJYouTubeIDParser
//
//  Created by Soneé John on 7/17/14.
//  Copyright (c) 2014 AlphaSoft. All rights reserved.
//

#import "SJYouTubeIDParser.h"

@implementation SJYouTubeIDParser
+ (NSString *)extractYoutubeID:(NSString *)youtubeURL
{
    NSError *error = NULL;
    
    //Create a NSRegularExpression object
    NSRegularExpression *regexExp = [NSRegularExpression regularExpressionWithPattern:@"(?<=v(=|/))([-a-zA-Z0-9_]+)|(?<=youtu.be/)([-a-zA-Z0-9_]+)" options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSRange rangeOfFirstMatch = [regexExp rangeOfFirstMatchInString:youtubeURL options:0 range:NSMakeRange(0, [youtubeURL length])];
    if(!NSEqualRanges(rangeOfFirstMatch, NSMakeRange(NSNotFound, 0)))
    {
        //Matches
        NSString *substringForFirstMatch = [youtubeURL substringWithRange:rangeOfFirstMatch];
        
        //Return Video ID
        return substringForFirstMatch;
        
    } else{
        
        //Error
        NSError *error = [NSError errorWithDomain:@"com.AlphaSoft.SJYouTubeIDParser.h" code:10 userInfo:nil];
        NSLog(@"SJYouTubeIDParser returned error: %@",error);
    }
    return nil;
}
@end
