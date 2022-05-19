/* ModuleDocument */

#import <Cocoa/Cocoa.h>

#import "InspectorDocument.h"
#import "OKModule.h"
#import "OKAggregateResource.h"

@interface ModuleDocument : InspectorDocument
{
    IBOutlet OKModule *module;  /* This contains the module model structures used
                                 to edit the module, instantiated by the
                                 ModuleDocument nib file */
}


@end
