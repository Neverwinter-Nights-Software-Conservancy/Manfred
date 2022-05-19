#import "OKStrrefProperty.h"
#import "OKDialogProperty.h"
#import "OKLocalizedStringProperty.h"
#import "OKPropertyResource.h"

@implementation OKStrrefProperty
-(void) initValueWithInfo: (struct okElementPropertyInfo) elementInfo
                    lists: (unsigned long int *) lists
             variableData: (NSData *)variableData
{
    /*  This must be reimplemented in every subclass */
    unsigned long int headerBuffer[3];
    struct okStrrefHeader strrefHeader;
    [variableData getBytes: headerBuffer range: NSMakeRange(elementInfo.offset,12)];
    okSwapMultipleLongs(headerBuffer, &strrefHeader, 3);
    unsigned long int nStrings = strrefHeader.nLanguages;
    if (strrefHeader.dialogIndex >= 0) nStrings++;
    value = [[NSMutableArray arrayWithCapacity: nStrings] retain];
    keys = [[NSMutableArray arrayWithCapacity: nStrings] retain];
    if (strrefHeader.dialogIndex >= 0)
    {
	[value addObject: [[OKDialogProperty alloc] initWithResource: resource
							 at: strrefHeader.dialogIndex]];
	[keys addObject: [NSNumber numberWithLong: -1]];
    }
    unsigned long int cursor = elementInfo.offset + 12;
    unsigned long int i;
    for (i=0; i<strrefHeader.nLanguages; i++) {
	OKLocalizedStringProperty *localizedString = [OKLocalizedStringProperty fromVariableData: variableData 				withCursor:&cursor in: resource];
	[value addObject:localizedString];
	[keys addObject:[localizedString languageCode]];
    }
    return;
}
-(void) dealloc
{
    [keys release];
    [super dealloc];
}
- (int)numberOfChildren
{
    return [value count];
}
- (OKProperty *) child: (int) index
{
    return [value objectAtIndex: index];
}
-(NSString *) type
{
    return @"Strref";
}

@end
