//
//  OKAggregateResource.h
//  Manfred
//
//  Created by Rick Shafer on Mon Apr 21 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "OKTypedResource.h"

struct okAggregateResourceHeader {
    unsigned long int nStrings;
    unsigned long int totalStringLength;
    unsigned long int nResources;
    unsigned long int firstStringOffset;
    unsigned long int firstResrefOffset;
    unsigned long int firstRangeOffset;
    unsigned long int creationYear;
    unsigned long int creationDOY;
    unsigned long int key;
    unsigned long int spare[29];
};
union okUnionAggregateResourceHeader {
    struct okAggregateResourceHeader h;
    unsigned int intvals[38];
};
struct okAggregateResourceResinfo {
    char name[16];
    unsigned long int index;
    unsigned long int code;
};

@interface OKAggregateResource : OKTypedResource {
    NSMutableArray *resources;
    NSMutableArray *resrefs;
    unsigned long int *indices;
    NSRange *ranges;
    NSDate *creationDate;
    union okUnionAggregateResourceHeader header;
}
-(int) nResources; // Number of resources in the Aggregate
-(NSDictionary *) resourceInfoForIndex: (int) resourceNumber; // Used for Inspector TableView info
-(OKResource *) resourceAtIndex: (int) anIndex; // returns resource as stored in array
-(NSString *) filenameAtIndex: (int) anIndex; // associated file name for the resource

@end
