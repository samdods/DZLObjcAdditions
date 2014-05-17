//
//  NSNS_t.h
//  MixinExample
//
//  Created by Sam Dods on 15/05/2014.
//  Copyright (c) 2014 Sam Dods. All rights reserved.
//

#import <objc/message.h>
#import "NSObject+DZLObjcAdditions.h"

#define safeSuper(...) \
struct objc_super dzlSuperClass_ = {self, self.class.superclass}; \
objc_msgSendSuper(&dzlSuperClass_, _cmd, __VA_ARGS__);


#define implementation_safe(class, name) \
interface class ## name ## MixinSafe_ : NSObject @end \
@implementation class ##name ##  MixinSafe_ \
+ (void)load { [class dzl_mixinSafeClass:self]; }
