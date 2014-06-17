//
//  DZLImplementationSafe
//  DZLObjcAdditions
//
//  Created by Sam Dods on 15/05/2014.
//  Copyright (c) 2014 Sam Dods. All rights reserved.
//

#import <objc/message.h>
#import "NSObject+DZLObjcAdditions.h"
#import "DZLSuper.h"

#define implementation_safe(class, name) \
interface MixinSafe_ ## class ## name : class @end \
@implementation MixinSafe_ ## class ## name \
+ (void)load { [class dzl_mixinSafeClass:self]; } @end \
@implementation MixinSafe_ ## class ## name (Additions)
