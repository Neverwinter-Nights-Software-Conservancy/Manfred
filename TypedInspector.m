#import "TypedInspector.h"

@implementation TypedInspector
-(void) dealloc
{
    [idField release];
    [versField release];
    [super dealloc];
}

-(void) windowDidLoad
{
    [super windowDidLoad];
    [idField setStringValue:[resource dataType]];
    [versField setStringValue:[resource dataVersion]];
}
@end
