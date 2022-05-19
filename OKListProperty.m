#import "OKListProperty.h"
#import "OKPropertyResource.h"

@implementation OKListProperty
-(void) initValueWithInfo: (struct okElementPropertyInfo) elementInfo
                    lists: (unsigned long int *) lists
             variableData: (NSData *)variableData
{
    /*  This must be reimplemented in every subclass */
    unsigned long int i = elementInfo.offset/4 ;
    unsigned long int nEntries = lists[i];
    unsigned long int j;
    value = [[NSMutableArray arrayWithCapacity: nEntries] retain];
    for (j=0; j<nEntries; j++) {
	i++;
	[value addObject: [resource entryPropertyAtIndex: lists[i] ]];
    }
    return;
}
- (int)numberOfChildren
{
    return [value count];
}
- (OKProperty *) child: (int) index
{
    return [value objectAtIndex: index];
}
- (id) outlineViewValue
{
    return @"";
}
-(NSString *) type
{
    return @"List";
}
- (void) dumpValueInHTMLTo: (NSMutableData *) dumpData
{
    NSStringEncoding icode = [NSString defaultCStringEncoding];
    int nEntries = [self numberOfChildren];
    [dumpData appendData: [[NSString stringWithFormat:
        @"<code>[***] = %i entries </code>", nEntries] dataUsingEncoding:icode]];
    if (nEntries > 0) {
        [dumpData appendData: [@" as follows\n<ul>\n" dataUsingEncoding:icode]];
        NSEnumerator *enumerator = [value objectEnumerator];
        id anElement;
        while((anElement = [enumerator nextObject])) {
            [dumpData appendData: [@"<li>" dataUsingEncoding:icode]];
            [anElement dumpHTMLTo: dumpData];
            [dumpData appendData: [@"</li>\n" dataUsingEncoding:icode]];
        }
        [dumpData appendData: [@"</ul>\n" dataUsingEncoding:icode]];
    }
}



@end
