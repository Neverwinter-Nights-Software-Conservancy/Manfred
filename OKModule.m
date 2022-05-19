#import "OKModule.h"

@implementation OKModule
- (void) setResource: (OKResource *)aResource
{
    [aResource retain];
    [resource release];
    resource = aResource;
}
- (void) dealloc
{
    [resource release];
    [super dealloc];
}
@end
