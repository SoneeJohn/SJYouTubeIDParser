//
//  AppDelegate.m
//  SJYouTubeIDParser Demo
//
//  Created by Soneé John on 7/17/14.
//  Copyright (c) 2014 AlphaSoft. All rights reserved.
//

#import "AppDelegate.h"
#import "SJYouTubeIDParser.h"
@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (IBAction)extractAction:(id)sender {
    
    
    //Create SJYouTubeIDParser object
   SJYouTubeIDParser *youtubeParser = [SJYouTubeIDParser defaultParser];
    //Start spinner
    //Undide it first
    [self.circularProgressIndicator setHidden:NO];
  [self.circularProgressIndicator startAnimation:nil];
    [youtubeParser getVideoInfoFromURL:@"http://www.youtube.com/watch?v=fmTpgSMJ96c" completionHandler:^(NSString *videoID, NSString *videoTitle, NSURL *thumbnailURL, NSString *videoDescription, NSString *viewCount, long long rating, NSDate *uploaded, NSString *uploader, NSError *error) {
        
        if (error == nil) {
            // No error
            //you can now get YouTube video's
            //video ID, thumbnail URL, video description, view count,rating, upload date, and the uploader

        
        } else{
            //Handle error
        }
        
    }];
  [youtubeParser getVideoInfoFromURL:[self.textField stringValue]  completionHandler:^(NSString *videoID, NSString *videoTitle, NSURL *thumbnailURL, NSString *videoDescription, NSString *viewCount, long long rating, NSDate *uploaded, NSString *uploader, NSError *error) {
      
  
      
      //NOTE: This uses GCD to trigger the blocks - they *WILL NOT* be called on THE MAIN THREAD
      // - In other words DO NOT DO ANY UI UPDATES IN THE BLOCKS.
      dispatch_async(dispatch_get_main_queue(), ^{
      //stop spinner
      [self.circularProgressIndicator stopAnimation:nil];
      if (error == nil) {
         
          //No error
          [self.videoTitleTextField setStringValue:videoTitle];
          
          [self.descriptionTextField setStringValue:videoDescription];
          
          
          NSImage *thumbnailImage = [[NSImage alloc]initByReferencingURL:thumbnailURL];
           //Set thumbnail
           [self.thumbnailImageView setImage:thumbnailImage];
        
          
          
          //Format view count
          NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
          [fmt setNumberStyle:NSNumberFormatterDecimalStyle]; // to get commas (or locale equivalent)
          [fmt setMaximumFractionDigits:0]; // to avoid any decimal
          

          NSInteger value = [viewCount intValue];
          
          NSString *result = [fmt stringFromNumber:@(value)];

          [self.viewCountTextField setStringValue:[NSString stringWithFormat:@"%@ views",result]];
          
           //Set rating Indicator
          //e.g value is Rating: 4
          [self.ratingIndicator setDoubleValue:rating];
          NSLog(@"Rating is: %lld",rating);
         
          //Set uploader
          [self.uploaderTextField setStringValue:[NSString stringWithFormat:@"by %@",uploader]];
         
          NSDate * today = [NSDate date];
         
          NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
          [dateFormatter setDateFormat:@"yyyy-MM-dd"];
          NSString *strDate = [dateFormatter stringFromDate:uploaded];
          
          NSString * str = strDate;
          NSDate * past = [NSDate dateWithNaturalLanguageString:str
                                                         locale:[[NSUserDefaults
                                                                  standardUserDefaults] dictionaryRepresentation]];
          
          
          NSCalendar *gregorian = [[NSCalendar alloc]
                                   initWithCalendarIdentifier:NSGregorianCalendar];
          unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |
          NSDayCalendarUnit |
          NSHourCalendarUnit | NSMinuteCalendarUnit |
          NSSecondCalendarUnit;
          NSDateComponents *components = [gregorian components:unitFlags
                                                      fromDate:past
                                                        toDate:today
                                                       options:0];
          
        
          

          if ([components year]) {
              [self.timeAgoTextField setStringValue:[NSString stringWithFormat:@"%ld years ago",(long)[components year]]];

          } else if ([components month]){
              [self.timeAgoTextField setStringValue:[NSString stringWithFormat:@"%ld months ago",(long)[components month]]];

          } else if ([components day]){
              [self.timeAgoTextField setStringValue:[NSString stringWithFormat:@"%ld days ago",(long)[components day]]];

          } else if ([components hour]){
              [self.timeAgoTextField setStringValue:[NSString stringWithFormat:@"%ld hours ago",(long)[components hour]]];

              
          } else if ([components minute]){
              [self.timeAgoTextField setStringValue:[NSString stringWithFormat:@"%ld minutes ago",(long)[components minute]]];

              
          } else if ([components second]){
              [self.timeAgoTextField setStringValue:[NSString stringWithFormat:@"%ld seconds ago",(long)[components second]]];

              
          }
          

      } else{
          //Handle error
          if ([error code] == 10) {
              NSLog(@"Invalid URL");
              NSRunAlertPanel(NSLocalizedString(@"Invalid URL", @"Invalid URL alert title"), NSLocalizedString(@"Unable to find any YouTube video with the URL you provided. Your URL should look something like this: http://www.youtube.com/watch?v=VpZmIiIXuZ0", @"Message for invalid URL ALert"), NSLocalizedString(@"OK", @"OK button for invalid URL alert"), nil, nil);

          } else if ([error code] == 11){
              NSLog(@"URL IS NIL");
              [NSApp presentError:error];

              
          } else{
              [NSApp presentError:error];

          }
      }
      });
      
  }];
      
 
    
    
    
}
@end
