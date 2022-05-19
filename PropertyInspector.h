//
//  PropertyInspector.h
//  Manfred
//
//  Created by Rick Shafer on Sat May 10 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "OKPropertyResource.h"
#import "TypedInspector.h"

@class OKProperty;

@interface PropertyInspector : TypedInspector {
    IBOutlet NSTextView * valueTextView; // used for editing extended text for Values outside outlineView
}
// outlineView data source methods
- (int)outlineView:(NSOutlineView *) outlineView numberOfChildrenOfItem: (id) item;
- (BOOL)outlineView:(NSOutlineView *) outlineView isItemExpandable: (id) item;
- (id)outlineView:(NSOutlineView *) outlineView child:(int) index ofItem:(id)item;
- (id)outlineView:(NSOutlineView *) outlineView objectValueForTableColumn:(NSTableColumn *) tableColumn
		  byItem:(id) item;
// support data source methods
- (OKProperty *) testItemForRoot: (id) item;
//
- (IBAction) dumpToHTML: (id) sender;
- (void) dumpSavePanelDidEnd: (NSSavePanel *) sp returnCode: (int) returnCode
                 contextInfo: (void *) dumpData; // sheet delegate method for the close sheet
@end
