//
//  OKAggregateResource.m
//  Manfred
//
//  Created by Rick Shafer on Mon Apr 21 2003.
//  Copyright (c) 2003 OpenKnights. All rights reserved.
//

#import "OKAggregateResource.h"
#import "OKResref.h"
@class AggregateInspector;

@implementation OKAggregateResource
-(OKResource *) initWithData:(NSData *)newData in:(id)aContainer as:(NSString *)anIdentifier
{
    [super initWithData: newData in: aContainer as:anIdentifier];
    if ([newData length] < 160) return self; // This needs to be cleaned up for a real empty case
    unsigned long int buffer[38];
    [newData getBytes: buffer range: NSMakeRange(8,152)];
    okSwapMultipleLongs(buffer,(long int *)header.intvals,38);
    resources = [[NSMutableArray arrayWithCapacity: header.h.nResources] retain];
    resrefs = [[NSMutableArray arrayWithCapacity: header.h.nResources] retain];
    NSLog(@"Array retain count: %i",[resources retainCount]);

    unsigned long int i;
    unsigned long int resinfoSize = header.h.nResources * sizeof(struct okAggregateResourceResinfo);
    unsigned long int resrangeSize = header.h.nResources *sizeof(NSRange);
    struct okAggregateResourceResinfo *resinfoArrayPtr = malloc(resinfoSize);
    NSRange *rangeArrayPtr = malloc(resrangeSize);
    ranges = malloc(resrangeSize);
    indices = malloc(header.h.nResources * sizeof(i));
    [newData getBytes: resinfoArrayPtr range: NSMakeRange(header.h.firstResrefOffset,resinfoSize)];
    [newData getBytes: rangeArrayPtr range: NSMakeRange(header.h.firstRangeOffset,resrangeSize)];
    okSwapMultipleLongs(rangeArrayPtr, ranges, 2*header.h.nResources);
    struct {
        unsigned long int index;
        unsigned long int code;
    } resinfo;
    OKResref *newResref;
    for (i=0; i < header.h.nResources ; i++) {
        okSwapMultipleLongs(&(resinfoArrayPtr[i].index), &resinfo, 2);
        indices[i] = resinfo.index;
        newResref =[OKResref withNamePtr: &(resinfoArrayPtr[i].name)
                                    code: resinfo.code];
        [resrefs addObject:newResref];
        [resources addObject: [OKResource
                            withData: [newData subdataWithRange: ranges[i]]
                                  in: self
                             forCode: [NSNumber numberWithLong: resinfo.code]
                                  as: [newResref description]]];        
    }
    free(rangeArrayPtr);
    free(resinfoArrayPtr);
    return self;
}
- (void) dealloc
{
    [resources release];
    [resrefs release];
    [creationDate release];
    free (indices);
    free (ranges);
    [super dealloc];
}

-(Class) inspector
{
    return [AggregateInspector class];
}
- (int) nResources
{
    return header.h.nResources;
}
-(NSDictionary *) resourceInfoForIndex: (int) resourceNumber {
    OKResref *curResref = [resrefs objectAtIndex: resourceNumber];
    int curCode = [curResref code];
    return [NSDictionary dictionaryWithObjectsAndKeys: [NSString stringWithFormat: @"%i",
        indices[resourceNumber]],@"index",
        [curResref name],@"name",
        [NSString stringWithFormat: @"%i", curCode],@"code",
        [OKResource typeForCode: curCode],@"type",
        nil];
}
-(OKResource *) resourceAtIndex: (int) anIndex {
    return [resources objectAtIndex: anIndex];
}
-(NSString *) filenameAtIndex: (int) anIndex {
    return [[resrefs objectAtIndex: anIndex] description];
}
@end
