//
//  OKResref.h
//  Manfred
//
//  Created by Rick Shafer on Mon Apr 28 2003.
//  Copyright (c) 2003 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface OKResref : NSObject {
    struct fullResref {
        char name[16];
        unsigned long int code;
    } theResref ;
}
+(OKResref *) withNamePtr: (char *) newNamePtr code: (unsigned long int) newCode; //factory method
-(OKResref *) initWithNamePtr: (char *) newNamePtr code: (unsigned long int) newCode; //designated init
-(NSString *) name;
-(long int) code;
@end
