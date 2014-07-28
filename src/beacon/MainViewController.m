//
//  MainViewController.m
//  beacon
//
//  Created by Paul Jackson on 25/07/2014.
//  Copyright (c) 2014 Paul Jackson. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController () <NSTableViewDataSource, NSTableViewDelegate>

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    return self;
}

#pragma mark - NSTableViewDelegate

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return 10;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    NSTableCellView *cellView = [tableView makeViewWithIdentifier:tableColumn.identifier
                                                            owner:self];
    if ([tableColumn.identifier isEqualToString:@"BeaconColumn"]) {
        cellView.textField.stringValue = [NSString stringWithFormat:@"Item %ld", (long)row];
        
        NSImage *image = [NSImage imageNamed:@"green.png"];
        cellView.imageView.image = image;
    }
    return cellView;
}

@end
