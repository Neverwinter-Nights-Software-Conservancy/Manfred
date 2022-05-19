/* OKDatrefProperty */

#import "OKElementProperty.h"
/*  Note that the value for the Datref is just an unswapped data object.  If it is in fact a structure that requires swapping from little endian form, this will require adding a delegate instance variable and some basic delegate methods. */

@interface OKDatrefProperty : OKElementProperty
{
}
@end
