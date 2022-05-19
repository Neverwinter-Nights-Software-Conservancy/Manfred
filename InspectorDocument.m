//
//  InspectorDocument.m
//  Manfred
//
//  Created by Rick Shafer on Sat Jul 05 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "InspectorDocument.h"


@implementation InspectorDocument

/*
- (NSString *)windowNibName {
    // Implement this to return a nib to load OR implement -makeWindowControllers to manually create your controllers.
    return @"InspectorDocument";
}
*/
- (void)makeWindowControllers
{
    [self okInspect: self];
}

-(IBAction) okInspect: (id) sender
{
    NSWindowController *newController = [[resource inspector] alloc];
    newController = [newController initWithResource: resource owner: newController];
    [newController window];
    [newController showWindow: self];
    [self addWindowController: newController];
    NSLog(@"Window controller retain: %i", [newController retainCount]);
}
- (void) dealloc
{
    [resource release];
    [super dealloc];
}

// These APIs are intended for documents that are stored as file wrappers using the NSFileWrapper class.  By default, these methods call the NSData based API above.  The default implementation only handles regular file file wrappers.
- (NSFileWrapper *)fileWrapperRepresentationOfType:(NSString *)type {
    /*  This needs to be updated when we actually save modified versions of the resource
    */
    return nil;
}

- (BOOL)loadFileWrapperRepresentation:(NSFileWrapper *)wrapper ofType:(NSString *)type {
    NSLog(@"loadFile");
    NSLog(type);
    resource = [[OKResource withWrapper:wrapper in: self] retain];

    return YES;
}


/*
 - (NSData *)dataRepresentationOfType:(NSString *)type {
    // Implement to provide a persistent data representation of your document OR remove this and implement the file-wrapper or file path based save methods.
    return nil;
}

- (BOOL)loadDataRepresentation:(NSData *)data ofType:(NSString *)type {
    // Implement to load a persistent data representation of your document OR remove this and implement the file-wrapper or file path based load methods.
    return YES;
}
*/

@end
