//
//  ResourceInspector.h
//  Manfred
//
//  Created by Rick Shafer on Mon Jun 16 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class OKResource;

@interface ResourceInspector : NSWindowController {
    OKResource *resource; //The data model
}

-(ResourceInspector *) initWithResource: (OKResource *) newResource owner: (id) anOwner; //designated initiator
-(NSString *) windowNibName; // Getting the Nib Name, by default the same as the class

@end
