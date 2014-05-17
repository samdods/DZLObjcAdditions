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
({ SEL newName = [DZLMixin underlyingSelectorForSelector:_cmd class:self.class]; \
((void *(*)(id, SEL, ...))objc_msgSend)(self, newName, ##args); })

#define implementation_combine(class, name) \
interface MixinCombine_ ## class ## name : NSObject @end \
@implementation MixinCombine_ ## class ## name \
+ (void)load { [class dzl_mixinCombineClass:self]; } @end \
@implementation MixinCombine_ ## class ## name (Additions)
