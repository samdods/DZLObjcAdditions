Handy Objective-C 'extensions'
================

### @implementation_combine

Like a normal category implementation with one crucial difference: any method already implemented on the underlying class is replaced in such a way that the original implementation is left in tact and can be invoked with `combineOriginal(args, ...)`.

### @implementation_safe

Like a normal category implementation, but any method already implemented on the underlying class is not replaced. If a method is implemented by a class from which the underlying class inherits, the implementation in the category is added to the underlying class and the super class's implementation can be invoked with `safeSuper(args, ...)`.

### @protocol_implementation

An implementation for a protocol specification. Any optional protocol methods may be implemented here and these methods will automatically be added to any class that conforms to the protocol. (Anyone familiar with Ruby could think of this as an Objective-C equivalent to a mixin.)


# Examples

### @implementation_combine

This is really useful if you're trying to separate concerns. For example, you might be implementing usage analytics in your app. You don't want to clutter your view controller with analytics code, because it doesn't belong there. Instead you can add a "combine" category, which effectively allows you to add new functionality to the original method.

```objc
#import "DZLImplementationCombine.h"

tion_combine(MainViewController, CombinedAdditions)

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

# Installing

Copy the DZLObjcAdditions directory into your project. Import the relevant header files as you need them:
* **@implementation_combine** defined in DZLImplementationCombine.h
* **@implementation_safe** defined in DZLImplementationSafe.h
* **@protocol_implementation** defined in DZLProtocolImplementation.h

# Warning

This library makes use of the Objective-C ability to 'swizzle' methods at runtime. The implementation is very simple and I believe it is much cleaner than other examples of achieving similar results, e.g. block injection. While some people would advise against extensive method swizzling, I see no harm in it when there is a valid use-case.

# Twitter

If you like this, you can [follow me on twitter][twitter] for more of the same!

[twitter]: http://twitter.com/dodsios
