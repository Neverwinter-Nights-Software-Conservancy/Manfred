#import "OKElementProperty.h"
#import "OKUint8Property.h"
#import "OKInt8Property.h"
#import "OKUint16Property.h"
#import "OKInt16Property.h"
#import "OKUint32Property.h"
#import "OKInt32Property.h"
#import "OKUint64Property.h"
#import "OKInt64Property.h"
#import "OKFloatProperty.h"
#import "OKDoubleProperty.h"
#import "OKStringProperty.h"
#import "OKResrefProperty.h"
#import "OKStrrefProperty.h"
#import "OKDatrefProperty.h"
#import "OKCaprefProperty.h"
#import "OKListProperty.h"
#import "OKPropertyResource.h"

@implementation OKElementProperty

+(OKElementProperty *) withElementInfo: (struct okElementPropertyInfo) elementInfo
                                  in: (OKPropertyResource *)aResource
                                  at: (unsigned long int) elementIndex
                               lists: (unsigned long int *)lists
                        variableData: (NSData *)variableData
{
    OKElementProperty * newProperty;
    switch (elementInfo.type) {
        case 0: newProperty = [OKUint8Property alloc]; break;
        case 1: newProperty = [OKInt8Property alloc]; break;
        case 2: newProperty = [OKUint16Property alloc]; break;
        case 3: newProperty = [OKInt16Property alloc]; break;
        case 4: newProperty = [OKUint32Property alloc]; break;
        case 5: newProperty = [OKInt32Property alloc]; break;
        case 6: newProperty = [OKUint64Property alloc]; break;
        case 7: newProperty = [OKInt64Property alloc]; break;
        case 8: newProperty = [OKFloatProperty alloc]; break;
        case 9: newProperty = [OKDoubleProperty alloc]; break;
        case 10: newProperty = [OKStringProperty alloc]; break;
        case 11: newProperty = [OKResrefProperty alloc]; break;
        case 12: newProperty = [OKStrrefProperty alloc]; break;
        case 13: newProperty = [OKDatrefProperty alloc]; break;
        case 14: newProperty = [OKCaprefProperty alloc]; break;
        case 15: newProperty = [OKListProperty alloc]; break;
        default: // need to clean up this to provide a good default
            break;
    }
        return [newProperty initWithElementInfo: elementInfo
                                             in: aResource
                                             at: elementIndex
                                          lists: lists
                                   variableData: variableData];
}
-(OKElementProperty *) initWithElementInfo: (struct okElementPropertyInfo) elementInfo
                                      in: (OKPropertyResource *)aResource
                                      at: (unsigned long int) elementIndex
                                   lists: (unsigned long int *)lists
                            variableData: (NSData *)variableData
{
    [super initWithResource: aResource at: elementIndex];
    nameIndex = elementInfo.nameIndex;
    name = [[aResource elementNameAtIndex: nameIndex] retain];
    [self initValueWithInfo: elementInfo lists: lists variableData: variableData];
    return self;
}
-(void) dealloc
{
    [name release];
    [value release];
    [super dealloc];
}
-(void) initValueWithInfo: (struct okElementPropertyInfo) elementInfo lists: (unsigned long int *) lists
                                                       variableData: (NSData *)variableData{
    /*  This must be reimplemented in every subclass */
    return;
}
-(NSString *) name
{
    return name;
}
- (NSNumber *) codeOrID
{
    return [NSNumber numberWithUnsignedLong: nameIndex];
}
- (id) outlineViewValue
{
    return value;
}
- (void) dumpHTMLTo: (NSMutableData *) dumpData
{
    NSStringEncoding icode = [NSString defaultCStringEncoding];
    [dumpData appendData: [[NSString stringWithFormat:
        @"<li><code>%@ <i>%@</i></code> - ¥.", [self type], [self name]] dataUsingEncoding:icode]];
    [self dumpValueInHTMLTo: dumpData];
    [dumpData appendData: [@"</li>\n" dataUsingEncoding:icode]];
}
- (void) dumpValueInHTMLTo: (NSMutableData *) dumpData
{
    NSStringEncoding icode = [NSString defaultCStringEncoding];
    [dumpData appendData: [[NSString stringWithFormat:
        @" <code>[***] = %@ </code>", [self outlineViewValue]] dataUsingEncoding:icode]];
}

@end
