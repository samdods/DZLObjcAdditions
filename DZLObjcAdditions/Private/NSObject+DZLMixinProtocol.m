//
//  NSObject+DZLMixinProtocol.m
//  MixinExample
//
//  Created by Sam Dods on 15/05/2014.
//  Copyright (c) 2014 Sam Dods. All rights reserved.
//

#import <objc/runtime.h>
#import "NSObject+DZLMixinProtocol.h"
#import "NSObject+DZLObjcAdditions.h"

@interface NSObject ()
+ (void)dzl_mixinSafeClass:(Class)mixinClass overrideSuper:(BOOL)shouldOverrideSuper replace:(BOOL)backupOriginal;
@end

@implementation NSObject (DZLMixinProtocol)

+ (void)mixinProtocol:(Protocol *)mixinProtocol
{
  const char *protocolName = protocol_getName(mixinProtocol);
  NSString *className = [NSString stringWithFormat:@"%sMixinProtocol_", protocolName];
  [self dzl_mixinSafeClass:NSClassFromString(className) overrideSuper:NO replace:NO];
}

@end
