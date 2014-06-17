//
//  DZLImplementationCombine.h
//  DZLObjcAdditions
//
//  Created by Sam Dods on 15/05/2014.
//  Copyright (c) 2014 Sam Dods. All rights reserved.
//

#import <objc/message.h>
#import "NSObject+DZLObjcAdditions.h"
#import "DZLSuper.h"

#define implementation_combine(class, name) \
interface MixinCombine_ ## class ## name : class @end \
@implementation MixinCombine_ ## class ## name \
+ (void)load { [class dzl_mixinCombineClass:self]; } @end \
@implementation MixinCombine_ ## class ## name (Additions)
