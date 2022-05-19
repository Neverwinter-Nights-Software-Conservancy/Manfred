//
//  ScriptInspector.m
//  Manfred
//
//  Created by Rick Shafer on Mon Jul 07 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "ScriptInspector.h"


@implementation ScriptInspector
- (void)dealloc
{
    [scriptTextView release];
    [super dealloc];
    return;
}
- (void)windowDidLoad
{
    [super windowDidLoad];
    [scriptTextView setString:[[NSString alloc] initWithData: [resource data]
                                                    encoding: [NSString defaultCStringEncoding]]];
}

@end
