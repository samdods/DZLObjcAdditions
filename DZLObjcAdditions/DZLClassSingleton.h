//
//  DZLClassSingleton.h
//  DZLObjcAdditions
//
//  Created by Sam Dods on 23/05/2014.
//  Copyright (c) 2014 Sam Dods. All rights reserved.
//


#define class_singleton(class, methodName) \
implementation class (Singleton_ ## methodName) \
+ (class *)methodName { \
static class *singleton; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
singleton = [class new]; \
}); \
return singleton; \
} \
@end
