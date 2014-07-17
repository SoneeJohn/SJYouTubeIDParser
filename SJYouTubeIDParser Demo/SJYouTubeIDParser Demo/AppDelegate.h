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
}

@property (assign) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSTextField *textField;
- (IBAction)extractAction:(id)sender;
@property (weak) IBOutlet NSTextField *videoIDLabel;
@end
