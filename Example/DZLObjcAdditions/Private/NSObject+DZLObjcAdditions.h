//
//  NSObject+DZLObjcAdditions.h
//  MixinExample
//
//  Created by Sam Dods on 15/05/2014.
//  Copyright (c) 2014 Sam Dods. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DZLObjcAdditions)

+ (void)dzl_mixinSafeClass:(Class)mixinClass;

+ (void)dzl_mixinCombineClass:(Class)mixinClass;

@end


@interface DZLMixin : NSProxy

+ (SEL)underlyingSelectorForSelector:(SEL)selector class:(Class)mixinClass;

@end
