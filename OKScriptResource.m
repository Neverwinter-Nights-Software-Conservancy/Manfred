//
//  OKScriptResource.m
//  Manfred
//
//  Created by Rick Shafer on Sun Jul 06 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import "OKScriptResource.h"

@class ScriptInspector;

@implementation OKScriptResource
-(Class) inspector
{
    return [ScriptInspector class];
}

@end
