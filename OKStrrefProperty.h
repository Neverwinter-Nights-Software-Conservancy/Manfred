/* OKStrrefProperty */

#import "OKElementProperty.h"

struct okStrrefHeader {
    unsigned long int nTotalBytes; // This value not always current
    long int dialogIndex;
    unsigned long int nLanguages;
};

@interface OKStrrefProperty : OKElementProperty
{
    NSMutableArray * keys; // NSNumber longs, which are either the language ID value, or -1, indicating that
    // the associated value is a dialog.tlk index, rather than a string.
}
@end
