Handy Objective-C 'Extensions'
================

This library includes extensions to enhance the language and to avoid the need for common boiler-plate code. It is light-weight and can be installed in a project completely risk-free.

# Summary of Extensions

### @implementation_combine

Like a normal category implementation with one crucial difference: any method already implemented on the underlying class is replaced in such a way that the original implementation is left in tact and can be invoked with `combineOriginal(args, ...)`.

### @implementation_safe

Like a normal category implementation, but any method already implemented on the underlying class is not replaced. If a method is implemented by a class from which the underlying class inherits, the implementation in the category is added to the underlying class and the super class's implementation can be invoked with `safeSuper(args, ...)`.

### @protocol_implementation

An implementation for a protocol specification. Any optional protocol methods may be implemented here and these methods will automatically be added to any class that conforms to the protocol. (Anyone familiar with Ruby could think of this as an Objective-C equivalent to a mixin.)

### @synthesize_lazy

Synthesize an instance variable getter method, in which the underlying ivar is returned if non-nil. If the ivar is nil the ivar is set to a new instance of the given type and returned.

### @class_singleton / @class_singleton_setup

Implements a class method with the given name, returning a singleton of the specified type, with optional additional setup.

# Examples

### @implementation_combine

This is really useful if you're trying to separate concerns. For example, you might be implementing usage analytics in your app. You don't want to clutter your view controller with analytics code, because it doesn't belong there. Instead you can add a "combine" category, which effectively allows you to add new functionality to the original method.

```objc
#import "DZLImplementationCombine.h"

@implementation_combine(MainViewController, CombinedAdditions)

- (void)viewDidAppear:(BOOL)animated
{
  combineOriginal(animated); // call the underlying method.
  
  // add extra functionality.
}

@end
```

The call to `combineOriginal` can be placed anywhere in the method, or it may be omitted completely (but that would defeat the objective).

You should pass all original arguments to `combineOriginal` in the same order they appear in the method selector.

If you need the return value from the original method, you must cast the result of `combineOriginal` to the required type.

### @implementation_safe

This is useful if you want to add a method to a class without risking replacing an existing implementation if one exists.

```objc
#import "DZLImplementationSafe.h"

@implementation_safe(MainViewController, SafeAdditions)

- (void)viewWillAppear:(BOOL)animated
{
  // do something here.
  
  safeSuper(animated);
  
  // do some more stuff here.
}

@end
```

The call to `safeSuper` can be placed anywhere in the method, or it may be omitted.

You should pass all original arguments to `safeSuper` in the same order they appear in the method selector.

If you need the return value from the original method, you must cast the result of `combineOriginal` to the required type.

### @protocol_implementation

This is useful if you want to provide default implementations for optional protocol methods.

```objc
#import "DZLProtocolImplementation.h"

@protocol_implementation(Talkative)

- (void)saySomething
{
  NSLog(@"Hello world!");
}

@end
```

### @synthesize_lazy

Lazy initialisation is common for many types of property, for example an `NSMutableArray` instance might be initialised as follows:

```objc
- (NSMutableArray *)transactions
{
  return _transactions ?: (_transactions = [NSMutableArray new]);
}
```

Using the `@synthesize_lazy` directive, it is simplified further as follows:

```objc
@synthesize_lazy (NSMutableArray, transactions);
```

You can place this directive at any place within your implementation.

### @class_singleton

Singletons are how we have a shared or default instance of a class, and are very common in Cocoa (`NSFileManager`, `NSNotificationCenter`, etc.). When we define them ourselves we repeat the same boiler-plate code over and over, throughout a project, which usually looks like the following:

```objc
+ (HTTPClient *)defaultClient
{
  static HTTPClient *defaultClient;
  static dispatch_once_t onceToken;
  
  dispatch_once(&onceToken, ^{
    defaultClient = [HTTPClient new];
  });
  
  return defaultClient;
}
```

This can be simplied by declaring the `@class_singleton` in your implementation:

```objc
@implementation HTTPClient

@class_singleton (HTTPClient, defaultClient);

// rest of implementation code here.

@end
```

If you need to expose your singleton in the interface, you can do so as you would normally, for example:

```objc
@interface HTTPClient

+ (instancetype)defaultClient;

@end
```

### @class_singleton_setup

Sometimes you may wish to perform further setup of your shared instance in your singleton method. Of course, common initialisation should be done in the `-init` method of your class, which will be invoked by the singleton method. But if there is any setup required specifically for the shared instance, it can achieved easily with the `@class_singleton_setup` directive:

```objc
@class_singleton_setup (HTTPClient, defaultClient,
  defaultClient.operationQueue = [NSOperationQueue new];
  defaultClient.operationQueue.maxConcurrentOperationCount = 5;
)
```

Using this method, you can refer to the newly-created shared instance by the same variable name as the name you have provided to the method. And in Xcode, you will be greeted by code-completion, which is nice!

# Installing

Available as a CocoaPod.

Alternatively, you can copy the DZLObjcAdditions directory into your project. Import the relevant header files as you need them:
* **@implementation_combine** defined in DZLImplementationCombine.h
* **@implementation_safe** defined in DZLImplementationSafe.h
* **@protocol_implementation** defined in DZLProtocolImplementation.h
* **@synthesize_lazy** defined in DZLSynthesizeLazy.h
* **@class_singleton** / **@class_singleton_setup** defined in DZLClassSingleton.h

# Disclaimer

This library makes use of the Objective-C ability to 'swizzle' methods at runtime. The implementation is very simple and I believe it is much cleaner than other examples of achieving similar results, e.g. block injection. While some people would advise against extensive method swizzling, I see no harm in it when there is a valid use-case.

Furthermore, none of the above extensions are really compiler directives. They are just macros. But the macros are written in such a way that they require the '@' symbol prefix, which I think makes them look cool!

# Twitter

If you like this, you can [follow me on twitter][twitter] for more of the same!

[twitter]: http://twitter.com/dodsios
