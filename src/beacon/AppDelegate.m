//
//  AppDelegate.m
//  beacon
//
//  Created by Paul Jackson on 25/07/2014.
//  Copyright (c) 2014 Paul Jackson. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface AppDelegate()

@property (strong) MainViewController *mainViewController;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.mainViewController = [[MainViewController alloc]
                               initWithNibName:@"MainViewController" bundle:nil];
    
    [self.window.contentView addSubview:self.mainViewController.view];
    self.mainViewController.view.frame = ((NSView *)self.window.contentView).bounds;
}

@end
