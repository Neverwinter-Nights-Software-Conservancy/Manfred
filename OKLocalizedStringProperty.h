//
//  OKLocalizedStringProperty.h
//  Manfred
//
//  Created by Rick Shafer on Tue May 06 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "OKProperty.h"

/* Like OKDialogProperty, OKLocalizedStringProperty is a support property class for OKStrrefProperty.
As such it inherits only from OKProperty and not from the Element or Entry derived classes.  In this case the index is not an entry into a resource table, but gives which language the String is localized to. */
struct okLocalizedStringHeader {
    unsigned long int languageCode;
    unsigned long int length;
};

@interface OKLocalizedStringProperty : OKProperty {
    NSString * value;
}
+(OKLocalizedStringProperty *) fromVariableData: (NSData *)variableData
								 withCursor: (unsigned long int *) cursor
						    in: (OKPropertyResource *) theResource;
-(NSNumber *)languageCode;
-(void)setValue: (NSString *)newValue;
@end
