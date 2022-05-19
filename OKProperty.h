/* OKProperty */
@class OKPropertyResource;

@interface OKProperty : NSObject
{
    OKPropertyResource *resource ; // The containing Resource, with all the tables (name, entry, element)
    unsigned long int resourceIndex; // The index in the appropriate Table in resource for the property
    NSMutableDictionary *outlineViewInfo; // Only filled in if the property is inspected, otherwise nil
}
-(OKProperty *) initWithResource: (OKPropertyResource *)newResource at: (unsigned long int) anIndex;
-(NSString *) type; // Returns a type description for the Property
// outlineView data source methods required by PropertyInspector
- (int)numberOfChildren;
- (BOOL)isExpandable;
- (OKProperty *) child: (int) index;
- (id) valueForColumn:(NSTableColumn *) tableColumn;
- (NSMutableDictionary *) fillInOutlineViewInfo; // fill in stuff that the Inspector will need
- (NSString *) name; // A name string
- (NSNumber *) codeOrID; // For Entries it's the entry code, for elements its the name id index
- (NSNumber *) outlineViewIndex; // an NSNumber version of the index for the outlineView
- (id) outlineViewValue; // an NSValue or equivalent to be used by the outlineView (and dump)
- (void) dumpHTMLTo: (NSMutableData *) dumpData; // dump an HTML representation of the contents
@end
