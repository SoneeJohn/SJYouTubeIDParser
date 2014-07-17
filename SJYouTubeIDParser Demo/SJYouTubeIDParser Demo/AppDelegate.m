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
    
    NSString *textFieldString = [self.textField stringValue];
    
    //Extract YouTube Video ID
   NSString *youtubeVideoID = [SJYouTubeIDParser extractYoutubeID:textFieldString];
    
    [self.videoIDLabel setStringValue:[NSString stringWithFormat:@"Video ID is: %@",youtubeVideoID]];
    
    
    
}
@end
