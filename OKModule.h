/* OKModule - This acts as the general model for the Module */

#import <Cocoa/Cocoa.h>
#import "OKResource.h"

@interface OKModule : NSObject

{
    OKResource *resource;  // The actual module information
}
- (void) setResource: (OKResource *) aResource;
@end
