#### Version 1.2.0 

* Updated to YouTube API V3
* Updated Screenshot (OS X Yosemite)
* Add **SJYouTubeIDParserThumbnailQuailty** property
* Added **APIKey** property. 
* **Note**: You need to specify this if you wish to fetch info about YouTube videos
* Updated Demo project to reflect the above changes

#### Version 1.1.2

* Small bug fix.
* Can how report if video is deleted or private.
* Updated Demo Project to reflect on the above changes
* Added MIT License.


#### Version 1.1.1

* Improved the library's usages of ``` NSError```
* Improved error reporting
* Updated Demo Project to reflect on the above changes

#### Version 1.1.0

* Added block methods
* Updated Demo Project
* When calling "getVideoInfoFromURL" you can now get YouTube video's
video ID, thumbnail URL, video description, view count,rating, upload date, and the uploader
* Added + defaultParser instance
* Fixed all known issues
* Now requires AFNetworking


#### Version 1.1.0 bc1

* Added blocks
* Updated Demo Project
* When calling "getVideoInfoFromURL" you can now get YouTube video's
video ID, thumbnail URL, video description, view count, and the rating
* Added + defaultParser instance

**Known issues:**
* Parser will crash if attemping to request video info with no internet
connection.

#### Version 1.0.0

* Initial version
