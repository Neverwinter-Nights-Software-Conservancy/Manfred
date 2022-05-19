//
//  OKTypedResource.h
//  Manfred
//
//  Created by Rick Shafer on Mon Apr 21 2003.
//  Copyright (c) 2003 OpenKnights. All rights reserved.
//

#import "OKResource.h"


@interface OKTypedResource : OKResource {
    NSString *dataType;
    NSString *dataVersion;
}
- (NSString *) dataType;
- (NSString *) dataVersion;

@end
