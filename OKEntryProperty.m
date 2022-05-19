#import "OKEntryProperty.h"
#import "OKPropertyResource.h"

@implementation OKEntryProperty
+(OKEntryProperty *) withEntryInfo: (struct okEntryPropertyInfo) entryInfo
                        inResource: (OKPropertyResource *) theResource
                                at: (unsigned long int) entryIndex
                          multiMap: (unsigned long int *) multiMap
{
    return [[OKEntryProperty alloc] initWithEntryInfo: entryInfo inResource: theResource
                                                   at: entryIndex multiMap: multiMap];
}
-(OKEntryProperty *) initWithEntryInfo: (struct okEntryPropertyInfo) entryInfo
                            inResource: (OKPropertyResource *) theResource
                                    at: (unsigned long int) entryIndex
                              multiMap: (unsigned long int *) multiMap
{
    [super initWithResource: theResource at: entryIndex];
    unsigned long int i;
    elementIndices = malloc(entryInfo.nElements*sizeof(long int));
    nElementIndices = entryInfo.nElements;
    if (entryInfo.nElements == 1) {
        elementIndices[0] = entryInfo.indexOrOffset;
    } else if (entryInfo.nElements > 1) {
        unsigned long int j = entryInfo.indexOrOffset / sizeof(long int);
        for (i=0; i<entryInfo.nElements ; i++) {
            elementIndices[i] = multiMap[j];
            j++;
        }
    }
    entryCode = [[NSNumber numberWithLong: entryInfo.code] retain];
    return self;
}

-(void)dealloc
{
    free(elementIndices);
    [entryCode release];
    [elements release];
    [super dealloc];
}
-(void) finalize
{
    long int i;
    elements = [[NSMutableArray arrayWithCapacity: nElementIndices] retain];
    for (i=0; i<nElementIndices; i++) {
        [elements addObject:[resource elementPropertyAtIndex: elementIndices[i]]];
    }
    
}
-(NSString *) type
{
    return @"Entry";
}
- (int)numberOfChildren
{
    return [elements count];
}
- (OKProperty *) child: (int) index
{
    return [elements objectAtIndex: index];
}
-(NSString *) name
{
    if ([entryCode longValue] == -1) {
	return @"Root Entry";
    } else {
	return @"Entry";
    }
}
- (NSNumber *) codeOrID
{
    return entryCode;
}
- (void) dumpHTMLTo: (NSMutableData *) dumpData
{
    NSStringEncoding icode = [NSString defaultCStringEncoding];
    [dumpData appendData: [[NSString stringWithFormat:
        @"%@ with code %@ containing %i elements -\n<ul>\n", [self name], entryCode,
        [self numberOfChildren]] dataUsingEncoding:icode]];
    NSEnumerator *enumerator = [elements objectEnumerator];
    id anElement;
    while((anElement = [enumerator nextObject])) {
        [anElement dumpHTMLTo: dumpData];
    }
    [dumpData appendData: [@"</ul>\n" dataUsingEncoding:icode]];
}

@end
