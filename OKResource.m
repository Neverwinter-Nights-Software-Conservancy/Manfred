//
//  OKResource.m
//  Manfred
//
//  Created by Rick Shafer on Sat Apr 19 2003.
//  Copyright (c) 2003 OpenKnights. All rights reserved.
//

#import "OKResource.h"

@class ResourceInspector;

void okSwapMultipleLongs(unsigned long *source, unsigned long * destination, unsigned long nValues){
    unsigned long int i;
    for (i=0; i < nValues; i++) {
        destination[i] = NSSwapLittleLongToHost(source[i]);
    }
}
void okUnswapMultipleLongs(unsigned long *source, unsigned long *destination, unsigned long nValues){
    unsigned long int i;
    for (i=0; i < nValues; i++) {
        destination[i] = NSSwapHostLongToLittle(source[i]);
    }
}

@class TypedInspector;
@implementation OKResource
+(OKResource *) instanceForData:(NSData *)newData forCode:(NSNumber *)aCode as:(NSString *)anIdentifier
{
    /*  when initializing a resource you need to make sure that you have the right subclass.
    The key is to find the correct subclass to actually return based on the type of the resource
    This type is first determined by the type code... then otherwise by the extension in the
    identifier, and finally by peeking in the first four bytes of the data array.
    */
    unsigned codeIndex;
    if (aCode != nil) {
        codeIndex = [[OKResource resourceCodes] indexOfObject: aCode];
    } else {
        codeIndex = NSNotFound;
    }
    if ((anIdentifier != nil) && (codeIndex == NSNotFound)) {
        codeIndex = [[OKResource resourceTypes] indexOfObject: [
                 [[anIdentifier pathExtension] uppercaseString] stringByPaddingToLength: 4 withString: @" " startingAtIndex: 0]
            ];
    }
    if ((codeIndex == NSNotFound) && ([newData length] > 3)) {
        unsigned char aBuffer[4];
        [newData getBytes: aBuffer range: NSMakeRange(0 , 4)];
        codeIndex = [[OKResource resourceTypes] indexOfObject: [NSString stringWithCString: (const char *) &aBuffer length: 4]];
    }
    if (codeIndex == NSNotFound) {
        codeIndex = [[OKResource resourceTypes] indexOfObject: @"????"];
    }
    // codeIndex should point to something now
    OKResource *newResource = [NSClassFromString([[OKResource resourceClasses] objectAtIndex: codeIndex]) alloc];
    NSLog (@"Retain Count newResource: %i", [newResource retainCount]);
    NSLog ([newResource description]);
    return newResource;
}

-(OKResource *) initWithData:(NSData *)newData
                          in:(id)aContainer
                          as:(NSString *) anIdentifier
{
    [super init];
    data = [newData retain];
    container = [aContainer retain];
    identifier = [anIdentifier retain];
    return self;
}

- (void) dealloc
{
    [data release];
    [container release];
    [identifier release];
    [super dealloc];
}

+(OKResource *) withData:(NSData *)newData in:(id)aContainer forCode:(NSNumber *)aCode as:(NSString *)anIdentifier
{
    return [[OKResource instanceForData: newData forCode: aCode as: anIdentifier] initWithData: newData in:aContainer as:anIdentifier];
}
+(OKResource *) withData:(NSData *)newData in:(id)aContainer as:(NSString *)anIdentifier
{
    return [self withData:newData in:aContainer forCode:nil as:anIdentifier];
}
/*
 +(OKResource *) withData:(NSData *)newData in:(id)aContainer forCode:(NSNumber *)aCode
{
    return [self withData:newData in:aContainer forCode:aCode as:nil];
}

*/
+(OKResource *) withWrapper:(NSFileWrapper *)wrapper in:(id)aContainer
{
    if ([wrapper isRegularFile]) {
        return [self withData:[wrapper regularFileContents] in:aContainer forCode:nil as:[wrapper filename]];
    }
    return nil; 
}

+(NSArray *) resourceCodes
{
    return [NSArray arrayWithObjects: [NSNumber numberWithLong: -1],
        [NSNumber numberWithLong: 7],
        [NSNumber numberWithLong: 2002],
        [NSNumber numberWithLong: 2009],
        [NSNumber numberWithLong: 2010],
        [NSNumber numberWithLong: 2011], //MOD
        [NSNumber numberWithLong: 2012], //ARE
        [NSNumber numberWithLong: 2013],
        [NSNumber numberWithLong: 2014],
        [NSNumber numberWithLong: 2015], //BIC
        [NSNumber numberWithLong: 2016],
        [NSNumber numberWithLong: 2017],
        [NSNumber numberWithLong: 2022],
        [NSNumber numberWithLong: 2023],
        [NSNumber numberWithLong: 2025], //UTI
        [NSNumber numberWithLong: 2027],
        [NSNumber numberWithLong: 2029],
        [NSNumber numberWithLong: 2030],
        [NSNumber numberWithLong: 2032],
        [NSNumber numberWithLong: 2033], // DDS
        [NSNumber numberWithLong: 2035],
        [NSNumber numberWithLong: 2036],
        [NSNumber numberWithLong: 2037],
        [NSNumber numberWithLong: 2038],
        [NSNumber numberWithLong: 2040], //UTE
        [NSNumber numberWithLong: 2042],
        [NSNumber numberWithLong: 2044],
        [NSNumber numberWithLong: 2045],
        [NSNumber numberWithLong: 2046],
        [NSNumber numberWithLong: 2047],  // GUI
        [NSNumber numberWithLong: 2051],
        [NSNumber numberWithLong: 2052],
        [NSNumber numberWithLong: 2053],
        [NSNumber numberWithLong: 2056],
        [NSNumber numberWithLong: 2057], // SAV
        [NSNumber numberWithLong: 2058],
        [NSNumber numberWithLong: 2060],
        [NSNumber numberWithLong: 2061],//HAK
        [NSNumber numberWithLong: 2062],//NWM
        [NSNumber numberWithLong: 2065],
        [NSNumber numberWithLong: 2066],
        [NSNumber numberWithLong: 9997], //ERF
        [NSNumber numberWithLong: 9998], //BIF
        [NSNumber numberWithLong: 9999], //KEY
        nil];
}

+(NSArray *) resourceTypes
{
    return [NSArray arrayWithObjects: @"????",
        @"INI ",
        @"MDL ",
        @"NSS ",
        @"NCS ",
        @"MOD ", //
        @"ARE ", //
        @"SET ",
        @"IFO ",
        @"BIC ", //
        @"WOK ",
        @"2DA ",
        @"TXI ",
        @"GIT ",
        @"UTI ", //
        @"UTC ",
        @"DLG ",
        @"ITP ",
        @"UTT ",
        @"DDS ", //
        @"UTS ",
        @"LTR ",
        @"GFF ",
        @"FAC ",
        @"UTE ", //
        @"UTD ",
        @"UTP ",
        @"DFT ",
        @"GIC ",
        @"GUI ", //
        @"UTM ",
        @"DWK ",
        @"PWK ",
        @"JRL ",
        @"SAV ", //
        @"UTW ",
        @"SSF ",
        @"HAK ", //
        @"NWM ", //
        @"PTM ",
        @"PTT ",
        @"ERF ",
        @"BIF ",
        @"KEY ",
        nil];
}

+(NSArray *) resourceClasses
{
    return [NSArray arrayWithObjects: @"OKResource",
        @"OKResource",
        @"OKResource",
        @"OKScriptResource",
        @"OKResource",
        @"OKAggregateResource", // MOD
        @"OKPropertyResource", // ARE
        @"OKPropertyResource",
        @"OKPropertyResource",
        @"OKPropertyResource", // BIC
        @"OKPropertyResource",
        @"OKTypedResource",
        @"OKPropertyResource",
        @"OKPropertyResource",
        @"OKPropertyResource", // UTI
        @"OKPropertyResource",
        @"OKPropertyResource",
        @"OKPropertyResource",
        @"OKPropertyResource",
        @"OKPropertyResource", // DDS
        @"OKPropertyResource",
        @"OKPropertyResource",
        @"OKPropertyResource",
        @"OKPropertyResource",
        @"OKPropertyResource", //UTE
        @"OKPropertyResource",
        @"OKPropertyResource",
        @"OKPropertyResource",
        @"OKPropertyResource",
        @"OKPropertyResource", // GUI
        @"OKPropertyResource",
        @"OKPropertyResource",
        @"OKPropertyResource",
        @"OKPropertyResource",
        @"OKAggregateResource", //SAV
        @"OKPropertyResource",
        @"OKPropertyResource",
        @"OKAggregateResource", //HAK
        @"OKAggregateResource", //NWM
        @"OKPropertyResource",
        @"OKPropertyResource",
        @"OKAggregateResource", //ERF
        @"OKTypedResource", //BIF
        @"OKTypedResource", //KEY
        nil];
}

+(NSString *) typeForCode: (long int) aCode
{
    NSNumber * codeNumber = [NSNumber numberWithLong: aCode];
    int codeIndex = [[self resourceCodes] indexOfObject: codeNumber];
    if ( codeIndex == NSNotFound ) {
	codeIndex = 0;
    }
    return [[self resourceTypes] objectAtIndex: codeIndex];
}

-(Class) inspector
{
    return [ResourceInspector class]; 
}
-(NSString *)identifier
{
    return identifier;
}
-(NSData *)data
{
    return data;
}
@end
