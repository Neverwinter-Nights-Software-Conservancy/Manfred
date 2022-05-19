//
//  OKPropertyResource.m
//  Manfred
//
//  Created by Rick Shafer on Wed Apr 30 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "OKPropertyResource.h"
#import "OKElementProperty.h"
@class PropertyInspector;


@implementation OKPropertyResource
-(OKResource *) initWithData:(NSData *)newData in:(id)aContainer as:(NSString *)anIdentifier
{
    [super initWithData: newData in: aContainer as: anIdentifier];
    unsigned long int buffer[12];
    [newData getBytes: buffer range: NSMakeRange(8,48)];
    okSwapMultipleLongs(buffer,(long int *)(&header),12);
    long int *multiMap = malloc(header.sizeMultiMap);
    char *bigBuffer = malloc([newData length]); // Way overkill... could be cleaner
    [newData getBytes: bigBuffer range: NSMakeRange(header.firstMultiMapOffset,
                                                    header.sizeMultiMap)];
    okSwapMultipleLongs(bigBuffer, multiMap, header.sizeMultiMap / sizeof(long int));
    unsigned long int entryPropertyInfoSize = sizeof(struct okEntryPropertyInfo)*header.nEntries;
    struct okEntryPropertyInfo *entryInfo = malloc(entryPropertyInfoSize);
    [newData getBytes: bigBuffer range: NSMakeRange(header.firstEntryOffset,
                                                    entryPropertyInfoSize)];
    okSwapMultipleLongs(bigBuffer, entryInfo, entryPropertyInfoSize / sizeof(long int));
    long int i;
    long int j;
    unsigned long int k;
    entries = [[NSMutableArray arrayWithCapacity: header.nEntries] retain];
    for (i=0; i < header.nEntries; i++) {
        [entries addObject:[OKEntryProperty withEntryInfo: entryInfo[i]
                                                       inResource: self
                                                       at: i
                                                 multiMap: multiMap]];
    }
    rootProperty = [[entries objectAtIndex: 0] retain];
    names = [[NSMutableArray arrayWithCapacity: header.nNames] retain];
    [newData getBytes:bigBuffer range:NSMakeRange(header.firstNameOffset, header.nNames*16)];
    j = 0;
    for (i=0; i< header.nNames; i++) {
        for (k=0; (k<16)&&(bigBuffer[j+k] != 0); k++);
        [names addObject:[NSString stringWithCString: &(bigBuffer[j]) length:k]];
        j += 16;
    }
    long int elementPropertyInfoSize = sizeof(struct okElementPropertyInfo)*header.nElements;
    struct okElementPropertyInfo *elementPropertyInfo = malloc(elementPropertyInfoSize);
    [newData getBytes: bigBuffer range: NSMakeRange(header.firstElementOffset,
                                                    elementPropertyInfoSize)];
    okSwapMultipleLongs(bigBuffer, elementPropertyInfo, elementPropertyInfoSize / sizeof(long int));
    unsigned long int *lists = malloc(header.sizeList);
    [newData getBytes: bigBuffer range: NSMakeRange(header.firstListOffset, header.sizeList)];
    okSwapMultipleLongs(bigBuffer, lists, header.sizeList / sizeof(long int));
    NSData *variableData = [newData subdataWithRange: NSMakeRange(header.firstVariableDataOffset,
                                                    header.sizeVariableData)];
    elements = [[NSMutableArray arrayWithCapacity: header.nElements] retain];
    for (k=0; k < header.nElements; k++)
    {
        [elements addObject:[OKElementProperty withElementInfo: elementPropertyInfo[k]
								   in:self
								   at:k
								lists:lists
							 variableData:variableData]];
    }
    NSEnumerator *enumerator = [entries objectEnumerator];
    id anEntry;
    while((anEntry = [enumerator nextObject])) {
        [anEntry finalize];
    }
    
    free(multiMap);
    free(bigBuffer);
    free(entryInfo);
    free(elementPropertyInfo);
    free(lists);
    return self;
}

-(void)dealloc
{
    [rootProperty release];
    [names release];
    [elements release];
    [entries release];
    [super dealloc];
    return;
}

-(OKEntryProperty *) entryPropertyAtIndex: (long int) index
{
    return [entries objectAtIndex: index];
}
-(OKElementProperty *) elementPropertyAtIndex: (long int) index
{
    return [elements objectAtIndex: index];
}
-(NSString *) elementNameAtIndex: (long int) index
{
    return [names objectAtIndex: index];
}
-(Class) inspector
{
    return [PropertyInspector class]; 
}
-(OKEntryProperty *) rootProperty
{
    return rootProperty;
}
@end
