//
//  NSObject+DZLObjcAdditions.h
//  DZLObjcAdditions
//
//  Created by Sam Dods on 15/05/2014.
//  Copyright (c) 2014 Sam Dods. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DZLObjcAdditions)

+ (void)dzl_implementationSafe:(Class)aClass;

+ (void)dzl_implementationCombine:(Class)aClass;

@end


@interface DZLObjcAdditions : NSProxy

+ (instancetype)proxyForObject:(id)object class:(Class)class toForwardSelector:(SEL)selector;

@end


@interface DZLObjcAdditions (MixinProtocol)

+ (void)mixinAllIfNecessary;

@end
