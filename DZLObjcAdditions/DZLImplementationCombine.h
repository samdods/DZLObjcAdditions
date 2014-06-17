//
//  DZLImplementationCombine.h
//  DZLObjcAdditions
//
//  Created by Sam Dods on 15/05/2014.
//  Copyright (c) 2014 Sam Dods. All rights reserved.
//

#import "NSObject+DZLObjcAdditions.h"
#import "DZLSuper.h"

#define implementation_combine(class, name) \
interface DZLImplementationCombine_ ## class ## name : class @end \
@implementation DZLImplementationCombine_ ## class ## name \
+ (void)load { [class dzl_implementationCombine:self]; } @end \
@implementation DZLImplementationCombine_ ## class ## name (Additions)
