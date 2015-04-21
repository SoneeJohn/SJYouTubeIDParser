SJYouTubeIDParser
=================

A small useful library to extract or parse out the YouTube Video ID from any YouTube URL. You can also use it to fetch information about a YouTube video e.g upload date, title, and thumbnail URL etc...

<img src="Screenshots/screenshot.png" width="654" height="1184">

## Requirements
- [AFNetworking](https://github.com/AFNetworking/AFNetworking)
- Runs on iOS 6.0 and later
- Runs on OS X 10.8 and later
- YouTube Data [API Key](https://developers.google.com/youtube/v3/getting-started) (For fetching video info)

## Usage

```
#import "SJYouTubeIDParser.h"
#import "AFNetworking.h"

```
## Get Video Identification
```objc
 SJYouTubeIDParser *youtubeVideoID = [SJYouTubeIDParser defaultParser];
    [youtubeVideoID extractYoutubeID:@"YouTube URL GOES HERE"];
    //This will return a 11 characters Video Identification e.g: w87fOAG8fjk

```

You can also use the new block method

```objc
    SJYouTubeIDParser *youtubeParser = [SJYouTubeIDParser defaultParser];
      [youtubeParser getVideoIDWithURL:@"http://www.youtube.com/watch?v=fmTpgSMJ96c" completionHandler:^(NSString *videoID, NSError *error) {
        
        if (error == nil) {
            // No error
            NSLog(@"Video ID is: %@",videoID);
        } else{
            //Handle error (Video is not a valid YouTube URL)
        }
        
    }];
```
## Get information about a YouTube Video
**Note**:You need a YouTube Data [API Key](https://developers.google.com/youtube/v3/getting-started) to use this method.

//Set API Key
youtubeParser.APIKey = @"YOUR KEY";

[youtubeParser getVideoInfoFromURL:@"http://www.youtube.com/watch?v=fmTpgSMJ96c" completionHandler:^(NSString *videoID, NSString *videoTitle, NSURL *thumbnailURL, NSString *videoDescription, NSString *viewCount, long long likeCount, long long dislikeCount, NSDate *uploaded, NSString *uploader, NSError *error) {
        
        if (error == nil) {
            // No error
            //you can now get YouTube video's
            //video ID, thumbnail URL, video description, view count,like count, dislike count, upload date, and the uploader

        
        } else{
            //Handle error
        }
        
    }];
 ```

## Supported video URLs are:

- http://www.youtube.com/watch?v=sapuE9Cui0g&feature=youtu.be
- http://www.youtube.com/watch?v=sapuE9Cui0g
- youtu.be/KFPtWedl7wg_U923
- http://www.youtube.com/watch?feature=player_detailpage&v=sapuE9Cui0g_U#t=31s

## License

SJYouTubeIDParser is available under the MIT license. See the [LICENSE](https://github.com/SoneeJohn/SJYouTubeIDParser/blob/master/LICENSE.md) file for more information.