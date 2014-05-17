DZLObjcAdditions
================

Some handy 'extensions' to the Objective-C language.

### @implementation_combine

Like a normal category implementation with one crucial difference: any method already implemented on the underlying class is replaced in such a way that the original implementation is left in tact and can be invoked with `combineOriginal(args, ...)`.

### @implementation_safe

Like a normal category implementation, but any method already implemented on the underlying class is not replaced. If a method is implemented by a class from which the underlying class inherits, the implementation in the category is added to the underlying class and the super class's implementation can be invoked with `safeSuper(args, ...)`.

### @protocol_implementation

An implementation for a protocol specification. Any optional protocol methods may be implemented here and these methods will automatically be added to any class that conforms to the protocol. (Anyone familiar with Ruby could think of this as an Objective-C equivalent to a mixin.)


# Examples

### @implementation_combine

This is really useful if you're interested in the separation of concerns. For example, you might be implementing usage analytics in your app. You don't want to clutter your view controller with analytics code, because it doesn't belong there. Instead you can add a "combine" category, which effectively allows you to add new functionality to the original method.

```objc
@implementation_combine(MainViewController, CombinedAdditions)

- (void)viewDidAppear:(BOOL)animated
{
  combineOriginal(animated); // call the underlying method.
  
  // add extra functionality.
}

@end
```

