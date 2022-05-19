//
//  OKPropertyResource.h
//  Manfred
//
//  Created by Rick Shafer on Wed Apr 30 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//
/* The Property Resource is what Bioware calls a GFF (General Format File?) resource */

#import "OKTypedResource.h"
#import "OKEntryProperty.h"
//#import "OKElementProperty.h"
//@class OKEntryProperty;
@class OKElementProperty;

struct okPropertyResourceHeader {
    unsigned long int firstEntryOffset;
    unsigned long int nEntries;
    unsigned long int firstElementOffset;
    unsigned long int nElements;
    unsigned long int firstNameOffset;
    unsigned long int nNames;
    unsigned long int firstVariableDataOffset;
    unsigned long int sizeVariableData;
    unsigned long int firstMultiMapOffset;
    unsigned long int sizeMultiMap;
    unsigned long int firstListOffset;
    unsigned long int sizeList;
};

struct okEntryPropertyInfo {
    long int code;
    unsigned long int indexOrOffset;
    unsigned long int nElements;
} ;

struct okElementPropertyInfo {
    unsigned long int type;
    unsigned long int nameIndex;
    union allTypes {
        struct ui8 {
            unsigned char fill[3];
            unsigned char value;
        } ui8;
        struct i8 {
            char fill[3];
            char value;
        } i8;
        struct ui16 {
            unsigned short fill;
            unsigned short value;
        } ui16;
        struct i16{
            short fill;
            short value;
        } i16;
        unsigned long int ui32Value;
        long i32Value;
        float floatValue;
        unsigned long int offset;
    };
};


@interface OKPropertyResource : OKTypedResource {
    struct okPropertyResourceHeader header;
    OKEntryProperty *rootProperty;
    NSMutableArray *names;
    NSMutableArray *elements;
    NSMutableArray *entries;
}
-(OKEntryProperty *) entryPropertyAtIndex: (long int) index;
-(OKElementProperty *) elementPropertyAtIndex: (long int) index;
-(NSString *) elementNameAtIndex: (long int) index;
-(OKEntryProperty *) rootProperty;

@end
