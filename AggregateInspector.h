/* AggregateInspector */

#import <Cocoa/Cocoa.h>
#import "OKTypedResource.h"
#import "TypedInspector.h"

@interface AggregateInspector : TypedInspector
{
    IBOutlet NSTableView *resourceTableView;
    NSDictionary *cachedRowInfo;
    int cachedRowNumber;
}
- (int) numberOfRowsInTableView:(NSTableView *) tableView; // TableView Datasource method
- (id) tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn
           row:(int) row; // TableView Datasource method
-(IBAction) okInspect: (id) sender ;  // An Inspect request has been made
@end
