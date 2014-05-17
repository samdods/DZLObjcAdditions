//
//  NSNS_d.h
//  MixinExample
//
//  Created by Sam Dods on 15/05/2014.
//  Copyright (c) 2014 Sam Dods. All rights reserved.
//

#import <objc/message.h>
#import "NSObject+DZLObjcAdditions.h"

#define combineOriginal(args...) \
SEL newName = [DZLMixin underlyingSelectorForSelector:_cmd class:self.class]; \
objc_msgSend(self, newName, ##args);


#define implementation_combine(class, name) \
interface class ## name ## MixinExtra_ : NSObject @end \
@implementation class ## name ##  MixinExtra_ \
+ (void)load { [class dzl_mixinExtraClass:self]; }
