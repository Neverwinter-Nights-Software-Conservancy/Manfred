//
//  PropertyInspector.m
//  Manfred
//
//  Created by Rick Shafer on Sat May 10 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "PropertyInspector.h"
#import "OKProperty.h"

@implementation PropertyInspector
- (void)dealloc
{
    [valueTextView release];
    [super dealloc];
    return;
}

- (int)outlineView:(NSOutlineView *) outlineView numberOfChildrenOfItem: (id) item{
    OKProperty * viewProperty = [self testItemForRoot: item];
    return [viewProperty numberOfChildren];
}
- (BOOL)outlineView:(NSOutlineView *) outlineView isItemExpandable: (id) item{
    OKProperty * viewProperty = [self testItemForRoot: item];
    return [viewProperty isExpandable];    
}
- (id)outlineView:(NSOutlineView *) outlineView child:(int) index ofItem:(id)item{
    OKProperty * viewProperty = [self testItemForRoot: item];
    return [viewProperty child: index];    
}
- (id)outlineView:(NSOutlineView *) outlineView objectValueForTableColumn:(NSTableColumn *) tableColumn
			 byItem:(id) item
{
    OKProperty * viewProperty = [self testItemForRoot: item];
    return [viewProperty valueForColumn: tableColumn];    
}
- (OKProperty *) testItemForRoot: (id) item
{
    OKProperty * property;
    if (item == nil){
	property = [(OKPropertyResource *)resource rootProperty];
    } else property = (OKProperty *) item;
    return property;
}
- (IBAction) dumpToHTML: (id) sender
{
    NSStringEncoding icode = [NSString defaultCStringEncoding];
    NSMutableData * dumpData = [[NSMutableData alloc] retain];
    NSString * resourceIdentifier = [resource identifier];

    [dumpData appendData: [[NSString stringWithFormat:@"<p>Contents of resource %@:\n",
                                                                   resourceIdentifier]
                                                    dataUsingEncoding:icode]];
    [[(OKPropertyResource *)resource rootProperty] dumpHTMLTo: dumpData];
    [dumpData appendData: [@"</p>\n" dataUsingEncoding:icode]];
    /* This is temporary way to view the dump info before saving it */
    [valueTextView setString:
        [[NSString alloc] initWithData: dumpData encoding: icode]];
    NSSavePanel *sp;
    sp = [NSSavePanel savePanel];
    [sp setRequiredFileType:@"html"];
    [sp beginSheetForDirectory:@"" file: resourceIdentifier modalForWindow:[self window]
                 modalDelegate:self
                didEndSelector:@selector(dumpSavePanelDidEnd:returnCode:contextInfo:)
                   contextInfo:dumpData];
}
- (void) dumpSavePanelDidEnd: (NSSavePanel *) sp returnCode: (int) returnCode
                 contextInfo: (void *) dumpData
{
    if (returnCode == NSOKButton) {
        if (![dumpData writeToFile: [sp filename] atomically: YES])
            NSBeep();
    }
    [(NSData *)dumpData release];
}
@end