/* OKElementProperty */

#import "OKProperty.h"
@class OKPropertyResource;

@interface OKElementProperty : OKProperty
{
    unsigned long int nameIndex; // index of element name string in resource name array
    NSString *name;
    id value; /* the actual elemental value, which could be an NSNumber or NSString, or OKEntryProperty or an NSArray of entry properties, depending on the subtype. */ 
}
+(OKElementProperty *) withElementInfo: (struct okElementPropertyInfo) elementInfo
                                  in: (OKPropertyResource *)aResource
                                  at: (unsigned long int) elementIndex
                               lists: (unsigned long int *)lists
                        variableData: (NSData *)variableData
    ; // convenience factory method

// N.B. the actual ElementProperty class is set in the factory method above
-(OKElementProperty *) initWithElementInfo: (struct okElementPropertyInfo) elementInfo
                                  in: (OKPropertyResource *)aResource
                                  at: (unsigned long int) elementIndex
                               lists: (unsigned long int *)lists
                        variableData: (NSData *)variableData; // designated initiator
-(void) initValueWithInfo: (struct okElementPropertyInfo) elementInfo lists: (unsigned long int *) lists
                                                       variableData: (NSData *)variableData;
- (void) dumpValueInHTMLTo: (NSMutableData *) dumpData; // add the value info to the
// HTML dump of the PropertyResource.
@end
