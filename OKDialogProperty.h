//
//  OKDialogProperty.h
//  Manfred
//
//  Created by Rick Shafer on Tue May 06 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "OKProperty.h"

/*  This is an exceptional OKProperty because it does not inherit from the OKEntryProperty or OKElementProperty classes, though it (and OKLocalizedString) are children of OKStrrefProperty. As such the OKProperty instance variable index is overriden to refer to the index in the dialog.tlk file the property refers to */
@interface OKDialogProperty : OKProperty {

}


@end
