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

+ (NSMutableDictionary *)underlyingSelectorByReplacementSelector
{
  static NSMutableDictionary *underlyingSelectorByReplacementSelector;
  static dispatch_once_t onceToken;
  _dispatch_once(&onceToken, ^{
    underlyingSelectorByReplacementSelector = [NSMutableDictionary new];
  });
  return underlyingSelectorByReplacementSelector;
};

+ (void)setUnderlyingSelector:(SEL)underlyingSelector forSelector:(SEL)selector class:(Class)mixinClass
{
  NSString *key = [self replacementSelectorNameForSelector:selector class:mixinClass];
  NSString *underlyingName = NSStringFromSelector(underlyingSelector);
  NSString *existingName = self.underlyingSelectorByReplacementSelector[key];
  if (existingName) {
    [self setUnderlyingSelector:NSSelectorFromString(existingName) forSelector:underlyingSelector class:mixinClass];
  }
  self.underlyingSelectorByReplacementSelector[key] = underlyingName;
}

+ (SEL)underlyingSelectorForSelector:(SEL)selector class:(Class)mixinClass
{
  NSString *key = [self replacementSelectorNameForSelector:selector class:mixinClass];
  NSString *underlyingName = self.underlyingSelectorByReplacementSelector[key];
  return NSSelectorFromString(underlyingName);
}

+ (NSString *)replacementSelectorNameForSelector:(SEL)selector class:(Class)mixinClass
{
  return [NSString stringWithFormat:@"%@_%@", NSStringFromClass(mixinClass), NSStringFromSelector(selector)];
}

@end



@implementation NSObject (DZLObjcAdditions)

+ (void)dzl_mixinSafeClass:(Class)mixinClass
{
  [self dzl_mixinClass:mixinClass overrideSuper:YES replace:NO];
}

+ (void)dzl_mixinCombineClass:(Class)mixinClass
{
  [self dzl_mixinClass:mixinClass overrideSuper:NO replace:YES];
}

+ (void)dzl_mixinClass:(Class)mixinClass overrideSuper:(BOOL)shouldOverrideSuper replace:(BOOL)shouldReplace
{
  [self dzl_doMixinClass:mixinClass overrideSuper:shouldOverrideSuper replace:shouldReplace];
  [object_getClass(self) dzl_doMixinClass:object_getClass(mixinClass) overrideSuper:shouldOverrideSuper replace:shouldReplace];
}

+ (void)dzl_doMixinClass:(Class)mixinClass overrideSuper:(BOOL)shouldOverrideSuper replace:(BOOL)shouldReplace
{
  uint numberOfMethods;
  Method *methods = class_copyMethodList(mixinClass, &numberOfMethods);
  for (uint m = 0; m < numberOfMethods; m++) {
    Method method = methods[m];
    SEL name = method_getName(method);
    const char *types = method_getTypeEncoding(method);
    
    if (!shouldReplace && !shouldOverrideSuper && [self instancesRespondToSelector:name]) {
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
  SEL newName = NSSelectorFromString([DZLMixin replacementSelectorNameForSelector:name class:mixinClass]);
  class_addMethod(self, newName, orgImp, types);
  [DZLMixin setUnderlyingSelector:newName forSelector:name class:self];
}

@end


@implementation DZLMixin (MixinProtocol)

+ (void)load
{
  uint numberOfClasses;
  Class *classes = objc_copyClassList(&numberOfClasses);
  for (uint c = 0; c < numberOfClasses; c++) {
    Class targetClass = classes[c];
    uint numberOfProtocols;
    __unsafe_unretained Protocol **protocols = class_copyProtocolList(targetClass, &numberOfProtocols);
    
    for (uint p = 0; p < numberOfProtocols; p++) {
      Protocol *protocol = protocols[p];
      [self mixinProtocol:protocol toClass:targetClass];
    }
    
    free(protocols);
  }
  free(classes);
}

+ (void)mixinProtocol:(Protocol *)mixinProtocol toClass:(Class)targetClass
{
  const char *protocolName = protocol_getName(mixinProtocol);
  NSString *className = [NSString stringWithFormat:@"MixinProtocol_%s", protocolName];
  
  Class mixinClass = NSClassFromString(className);
  if (mixinClass && mixinClass != targetClass && [targetClass isSubclassOfClass:NSObject.class]) {
    [targetClass dzl_mixinClass:mixinClass overrideSuper:NO replace:NO];
  }
}

@end