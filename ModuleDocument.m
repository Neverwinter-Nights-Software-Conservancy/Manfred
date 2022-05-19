//
//  ModuleDocument.m
//
//  Created by Rick Shafer on Tue Apr 15 2003.
//  Copyright (c) 2003 Open Knights Consortium. All rights reserved.
//

#import "ModuleDocument.h"


@implementation ModuleDocument

- (id)init
{
    self = [super init];
    if (self) {

        // Add your subclass-specific initialization here.
        // If an error occurs here, send a [self release] message and return nil.

    }
    NSLog(@"ModuleDocument init");
    NSLog([module description]);
    resource = [OKResource withData: nil in: self as:@"untitled.mod"];
    NSLog(@"RC: %i",[resource retainCount]);

    return self;
}


- (NSString *)windowNibName {
    // Implement this to return a nib to load OR implement -makeWindowControllers to manually create your controllers.
    return @"ModuleDocument";
}

// These APIs are intended for documents that are stored as file wrappers using the NSFileWrapper class.  By default, these methods call the NSData based API above.  The default implementation only handles regular file file wrappers.
- (NSFileWrapper *)fileWrapperRepresentationOfType:(NSString *)type {
    return nil;
}

- (BOOL)loadFileWrapperRepresentation:(NSFileWrapper *)wrapper ofType:(NSString *)type {
    NSLog(@"loadFile");
    NSLog(type);
    NSLog([module description]);
    NSLog(@"RC: %i",[module retainCount]);
    resource = [[OKResource withWrapper:wrapper in: self] retain];

    return YES;
}

- (void)windowControllerDidLoadNib:(NSWindowController *) aController
{
    [super windowControllerDidLoadNib:aController];
    // Add any code here that needs to be executed once the windowController has loaded the document's window.
    NSLog(@"DidLoadNib");
    [module setResource:resource]; // Sets the module to use the resource
}
- (void) dealloc
{
    [module release];
    [super dealloc];
}


@end
