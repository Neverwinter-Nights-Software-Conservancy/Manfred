//
//  ScriptInspector.h
//  Manfred
//
//  Created by Rick Shafer on Mon Jul 07 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "ResourceInspector.h"


@interface ScriptInspector : ResourceInspector {
    IBOutlet NSTextView * scriptTextView; // The Script viewer

}

@end
