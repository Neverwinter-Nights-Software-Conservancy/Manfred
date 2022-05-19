/* OKEntryProperty */

#import "OKProperty.h"
@class OKPropertyResource;

@interface OKEntryProperty : OKProperty
{
    unsigned long int *elementIndices; // Indices of Entry child elements - not used after finalized
    unsigned long int nElementIndices; // not used after finalized
    NSNumber *entryCode;
    NSMutableArray *elements;
}
+(OKEntryProperty *) withEntryInfo: (struct okEntryPropertyInfo) entryInfo
                        inResource: (OKPropertyResource *) theResource
                                at: (unsigned long int) entryIndex
                          multiMap: (unsigned long int *) multiMap; //convenience factory method
-(OKEntryProperty *) initWithEntryInfo: (struct okEntryPropertyInfo) entryInfo
                        inResource: (OKPropertyResource *) theResource
                                at: (unsigned long int) entryIndex
                          multiMap: (unsigned long int *) multiMap; //designated init
-(void) finalize; /* This must be run after the init, and after the element properties have been
created in the containing resource.  (See OKPropertyResource inits). */
@end
