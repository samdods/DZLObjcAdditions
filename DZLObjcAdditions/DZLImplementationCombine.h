//
//  DZLImplementationCombine.h
//  DZLObjcAdditions
//
//  Created by Sam Dods on 15/05/2014.
//  Copyright (c) 2014 Sam Dods. All rights reserved.
//

#import "NSObject+DZLObjcAdditions.h"
#import "DZLSuper.h"

#define dzlCombine(args) \
({ id proxy = [DZLObjcAdditions proxyForObject:self class:self.class toForwardSelector:_cmd]; \
[proxy args]; })

#define dzl_no_assert 37834

#define implementation_combine(klass, name, args...) \
interface DZLImplementationCombine_ ## klass ## name : klass @end \
@implementation DZLImplementationCombine_ ## klass ## name \
+ (void)load { dzl_implementationCombine(klass.class, self, ##args); } @end \
@implementation DZLImplementationCombine_ ## klass ## name (Additions)
