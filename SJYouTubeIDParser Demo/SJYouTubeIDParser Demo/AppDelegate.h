//
//  AppDelegate.h
//  SJYouTubeIDParser Demo
//
//  Created by Soneé John on 7/17/14.
//  Copyright (c) 2014 AlphaSoft. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>{
    
    __weak NSTextField *_videoIDLabel;
    __weak NSTextField *_textField;

    __weak NSTextField *_videoTitleTextField;

    __weak NSProgressIndicator *_circularProgressIndicator;

    __weak NSTextField *_descriptionTextField;


    __weak NSTextField *_timeAgoTextField;
    __weak NSImageView *_thumbnailImageView;

    __weak NSTextField *_uploaderTextField;
    __weak NSLevelIndicator *_ratingIndicator;

    __weak NSTextField *_viewCountTextField;
}

@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTextField *likesLabel;
@property (weak) IBOutlet NSTextField *dislikesLabel;

@property (weak) IBOutlet NSTextField *textField;
- (IBAction)extractAction:(id)sender;
@property (weak) IBOutlet NSTextField *videoIDLabel;
@property (weak) IBOutlet NSTextField *videoTitleTextField;
@property (weak) IBOutlet NSTextField *descriptionTextField;
@property (weak) IBOutlet NSImageView *thumbnailImageView;
@property (weak) IBOutlet NSTextField *viewCountTextField;
@property (weak) IBOutlet NSLevelIndicator *ratingIndicator;
@property (weak) IBOutlet NSProgressIndicator *circularProgressIndicator;
@property (weak) IBOutlet NSTextField *timeAgoTextField;
@property (weak) IBOutlet NSTextField *uploaderTextField;
@end
