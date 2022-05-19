//
//  InspectorDocument.h
//  Manfred
//
//  Created by Rick Shafer on Sat Jul 05 2003.
//  Copyright (c) 2003 Open Knights Consortium. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "OKResource.h"


@interface InspectorDocument : NSDocument {
    OKResource *resource; // The actual resource data
}
-(IBAction) okInspect: (id) sender ;  // Open an inspector on the document's resource (Note this can also
                                      // cause the resource to be modified, so we need to be careful to keep the multiple views in synch.)
@end
