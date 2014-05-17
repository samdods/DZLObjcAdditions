DZLObjcAdditions
================

Some useful 'extensions' to the Objective-C language.

* **@implementation_combine(Class, CategoryName)**

Like a category, but any method that already exists on the underlying class is backed up and can be called with combineOriginal(args, ...)
