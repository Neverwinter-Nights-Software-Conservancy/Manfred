//
//  OKResource.h
//  Manfred
//
//  Created by Rick Shafer on Sat Apr 19 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

void okSwapMultipleLongs(unsigned long *source, unsigned long * destination, unsigned long nValues);
void okUnswapMultipleLongs(unsigned long *source, unsigned long *destination, unsigned long nValues);

@interface OKResource : NSObject {
    id container;  // The source of the resource, usually another OKResource or a document
    NSData *data; // The actual resource data (except for FolderAggregateResources)
    NSString *identifier; // a file name or resref plus type extension

}
// Get the appropriate subclass depending on the resource type
+(OKResource *) instanceForData:(NSData *)newData forCode:(NSNumber *)aCode as:(NSString *)anIdentifier;
-(OKResource *) initWithData:(NSData *)newData
                          in:(id)aContainer
                          as:(NSString *)anIdentifier;  // designated initiator
//  Class convenience factory methods
+(OKResource *) withData:(NSData *)newData in:(id)aContainer forCode:(NSNumber *)aCode as:(NSString *)anIdentifier;
+(OKResource *) withData:(NSData *)newData in:(id)aContainer as:(NSString *)anIdentifier;
/*+(OKResource *) withData:(NSData *)newData in:(id)aContainer forCode:(NSNumber *)aCode;*/
+(OKResource *) withWrapper:(NSFileWrapper *)wrapper in:(id)aContainer;  // the wrapper filename gives the type
// The Resource type arrays
+(NSArray *) resourceCodes;
+(NSArray *) resourceTypes;
+(NSArray *) resourceClasses;
+(NSString *) typeForCode: (long int) aCode;

-(Class) inspector; // Returns the WindowController subclass used for an inspector
-(NSString *)identifier; // The resource name and type as a character string
-(NSData *)data; // The actual resource data

@end
