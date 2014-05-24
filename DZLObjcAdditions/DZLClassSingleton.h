//
//  DZLClassSingleton.h
//  DZLObjcAdditions
//
//  Created by Sam Dods on 23/05/2014.
//  Copyright (c) 2014 Sam Dods. All rights reserved.
//


#define class_singleton(class, methodName) \
+ (class *)methodName { \
static class *methodName; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
methodName = [class new]; \
}); \
return methodName; \
}


#define class_singleton_setup(class, methodName, setupCode) \
+ (class *)methodName { \
static class *methodName; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
methodName = [class new]; \
({setupCode;});\
}); \
return methodName; \
}
