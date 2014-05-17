//
//  NSNS_t.h
//  MixinExample
//
//  Created by Sam Dods on 15/05/2014.
//  Copyright (c) 2014 Sam Dods. All rights reserved.
//

#import <objc/message.h>
#import "NSObject+DZLObjcAdditions.h"

#define safeSuper(args...) \
({ struct objc_super dzlSuperClass_ = {self, self.class.superclass}; \
((void *(*)(struct objc_super *, SEL, ...))objc_msgSendSuper)(&dzlSuperClass_, _cmd, ##args); })


#define implementation_safe(class, name) \
interface MixinSafe_ ## class ## name : NSObject @end \
@implementation MixinSafe_ ## class ## name \
+ (void)load { [class dzl_mixinSafeClass:self]; } @end \
@implementation MixinSafe_ ## class ## name (Additions)
