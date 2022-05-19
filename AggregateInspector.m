#import "AggregateInspector.h"

@implementation AggregateInspector

-initWithResource: (OKTypedResource *) newResource owner: (id) newOwner
{
    [super initWithResource: newResource owner: newOwner];
    cachedRowNumber = -1;
    return self;
}

-(void) dealloc
{
    [resourceTableView release];
    [cachedRowInfo release];
    [super dealloc];
}

- (int) numberOfRowsInTableView:(NSTableView *) tableView
{
    return [resource nResources];
}
- (id) tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn
           row:(int) row
{
    if (row != cachedRowNumber) {
        cachedRowNumber = row;
        [cachedRowInfo release];
        cachedRowInfo = [[resource resourceInfoForIndex: row] retain];
    }
    return [cachedRowInfo objectForKey: [tableColumn identifier]];
}
-(IBAction) okInspect: (id) sender  {
    // Look at the TableView for selected resources and then inspect them.
    NSEnumerator * rowEnumerator = [resourceTableView selectedRowEnumerator];
    NSNumber * selectedRow;
    OKResource * selectedResource;
    int rowInt;
    NSString * titlePrefix = [[[self window] title] stringByAppendingString: @"/"];
    NSString * resourceName;
    while (selectedRow = [rowEnumerator nextObject]) {
        rowInt = [selectedRow longValue];
        resourceName = [resource filenameAtIndex: rowInt];
	selectedResource = [resource resourceAtIndex:rowInt];
	NSWindowController *newInspector = [[selectedResource inspector] alloc];
	newInspector = [newInspector initWithResource: selectedResource owner:newInspector];
	[[self document] addWindowController: newInspector]; 
	NSWindow * theWindow = [newInspector window];
        [theWindow setTitle: [titlePrefix stringByAppendingString: resourceName]];
	[newInspector showWindow: self];
    }
    
}

@end
