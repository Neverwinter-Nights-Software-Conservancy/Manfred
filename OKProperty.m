#import "OKProperty.h"
#import "OKPropertyResource.h"

@implementation OKProperty
-(OKProperty *) initWithResource: (OKPropertyResource *)newResource at: (unsigned long int) anIndex
{
    [super init];
    resource = [newResource retain];
    resourceIndex = anIndex;
    return self;
}

-(void) dealloc
{
    [resource release];
    [outlineViewInfo release];
    [super dealloc];
}
-(NSString *) type
{
    return NSStringFromClass([self class]);
}
- (int)numberOfChildren
{
    return 0;
}
- (BOOL)isExpandable
{
    return ([self numberOfChildren] > 0);
}
- (OKProperty *) child: (int) index
{
    return nil;
}
- (id) valueForColumn:(NSTableColumn *) tableColumn
{
    if (outlineViewInfo == nil) {
	outlineViewInfo = [[self fillInOutlineViewInfo] retain];
    }
    return [outlineViewInfo objectForKey: [tableColumn identifier]];
}
-(NSMutableDictionary *) fillInOutlineViewInfo
{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys: 
	[self name], @"name",
	[self codeOrID], @"codeOrID",
	[self outlineViewIndex],@"index",
	[self type],@"type",
	[self outlineViewValue],@"value",
	nil];
}
-(NSString *) name
{
    return @"";
}
- (NSNumber *) codeOrID
{
    return nil;
}
- (NSNumber *) outlineViewIndex
{
    return [NSNumber numberWithUnsignedLong: resourceIndex];
}
- (id) outlineViewValue
{
    return @"";
}
- (void) dumpHTMLTo: (NSMutableData *) dumpData
{
    [dumpData appendData: [@"General property<br />\n" dataUsingEncoding:
        [NSString defaultCStringEncoding]]];
}
@end