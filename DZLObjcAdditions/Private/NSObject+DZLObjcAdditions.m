//
//  NSObject+DZLObjcAdditions.m
//  MixinExample
//
//  Created by Sam Dods on 15/05/2014.
//  Copyright (c) 2014 Sam Dods. All rights reserved.
//

#import <objc/runtime.h>
#import "NSObject+DZLObjcAdditions.h"


@implementation DZLMixin

+ (NSMutableDictionary *)underlyingSelectorByKey
{
  static NSMutableDictionary *dictionary;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    dictionary = [NSMutableDictionary new];
  });
  return dictionary;
}

+ (void)setUnderlyingSelector:(SEL)underlyingSelector forSelector:(SEL)selector class:(Class)mixinClass
{
  NSString *key = [self keyForSelector:selector class:mixinClass];
  NSString *underlyingName = NSStringFromSelector(underlyingSelector);
  NSString *existingName = self.underlyingSelectorByKey[key];
  if (existingName) {
    [self setUnderlyingSelector:NSSelectorFromString(existingName) forSelector:underlyingSelector class:mixinClass];
  }
  self.underlyingSelectorByKey[key] = underlyingName;
}

+ (SEL)underlyingSelectorForSelector:(SEL)selector class:(Class)mixinClass
{
  NSString *key = [self keyForSelector:selector class:mixinClass];
  NSString *underlyingName = self.underlyingSelectorByKey[key];
  return NSSelectorFromString(underlyingName);
}

+ (NSString *)keyForSelector:(SEL)selector class:(Class)mixinClass
{
  return [NSString stringWithFormat:@"%@_%@", NSStringFromClass(mixinClass), NSStringFromSelector(selector)];
}

@end



@implementation NSObject (DZLObjcAdditions)

+ (void)dzl_mixinSafeClass:(Class)mixinClass
{
  [self dzl_mixinSafeClass:mixinClass overrideSuper:YES replace:NO];
}

+ (void)dzl_mixinExtraClass:(Class)mixinClass
{
  [self dzl_mixinSafeClass:mixinClass overrideSuper:NO replace:YES];
}

+ (void)dzl_mixinSafeClass:(Class)mixinClass overrideSuper:(BOOL)shouldOverrideSuper replace:(BOOL)shouldReplace
{
  uint numberOfMethods;
  Method *methods = class_copyMethodList(mixinClass, &numberOfMethods);
  for (uint m = 0; m < numberOfMethods; m++) {
    Method method = methods[m];
    SEL name = method_getName(method);
    const char *types = method_getTypeEncoding(method);
    
    if (shouldOverrideSuper && [self instancesRespondToSelector:name]) {
      continue;
    }
    
    IMP imp = method_getImplementation(method);
    
    if (shouldReplace) {
      [self backupSelector:name forClass:mixinClass objcTypes:types];
      class_replaceMethod(self, name, imp, types);
    } else {
      class_addMethod(self, name, imp, types);
    }
  }
  free(methods);
}

+ (void)backupSelector:(SEL)name forClass:(Class)mixinClass objcTypes:(const char *)types
{
  IMP orgImp = class_getMethodImplementation(self, name);
  NSString *nameString = NSStringFromSelector(name);
  nameString = [NSStringFromClass(mixinClass) stringByAppendingFormat:@"_%@", nameString];
  SEL newName = NSSelectorFromString(nameString);
  class_addMethod(self, newName, orgImp, types);
  [DZLMixin setUnderlyingSelector:newName forSelector:name class:self];
}

@end
