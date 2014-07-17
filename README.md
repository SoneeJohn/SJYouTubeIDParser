SJYouTubeIDParser
=================

A small useful library to extract or parse out the YouTube Video ID from a YouTube URL. The library can be used in a ton of scenarios such as using the Video ID for JSON requests via the YouTube API.
## Usage

```
#import "SJYouTubeIDParser.h"
```

```objc
//Create NSString object
//This will store the YouTube Video ID

NSString *youtubeVideoID = [SJYouTubeIDParser extractYoutubeID:@"YouTube URL GOES HERE"];

```
##Supported video URLs are:

- http://www.youtube.com/watch?v=sapuE9Cui0g&feature=youtu.be
- http://www.youtube.com/watch?v=sapuE9Cui0g
- youtu.be/KFPtWedl7wg_U923
- http://www.youtube.com/watch?feature=player_detailpage&v=sapuE9Cui0g_U#t=31s

**Note**: This is the inital version more features are coming soon.