//
//  DZLViewControllerAdditions.h
//  Example
//
//  Created by Sam Dods on 14/05/2014.
//  Copyright (c) 2014 Sam Dods. All rights reserved.
//

#import "DZLImplementationCombine.h"
#import "DZLImplementationSafe.h"
#import "DZLProtocolImplementation.h"
#import "DZLViewControllerAdditions.h"

@protocol_implementation(TestProtocol)

- (void)doSomethingMagic
{
  NSLog(@"in default doSomethingMagic");
}

@end


@protocol_implementation(TestProtocol2)

- (void)doSomethingElseMagic
{
  NSLog(@"in default doSomethingElseMagic");
}

@end


@implementation_safe(DZLViewController, Example)

- (void)viewWillAppear:(BOOL)animated
{
  NSLog(@"in safe viewWillAppear:");
  
  dzlSuper(viewWillAppear:animated);
}

- (BOOL)isSomething
{
  NSLog(@"in safe isSomething");
  
  return dzlSuper(isSomething);
}

@end


@implementation_combine(DZLViewController, Example)

+ (BOOL)shouldDoSomethingWithObject:(id)object
{
  NSLog(@"in combined shouldDoSomethingWithObject:");
  
  BOOL should = dzlSuper(shouldDoSomethingWithObject:object);
  
  return should;
}

- (void)viewDidLoad
{
  NSLog(@"in combined viewDidLoad");
  
  dzlSuper(viewDidLoad);
}

@end

@implementation_combine(DZLViewController, ExampleNoAssert, dzl_no_assert)

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  dzlCombine(scrollViewDidScroll:scrollView);
  
  BOOL hasUnderlyingMethod = dzlCanCombine();
  NSLog(@"scroll view scrolled (%zd)", hasUnderlyingMethod);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
  dzlCombine(scrollViewDidEndDecelerating:scrollView);
  
  BOOL hasUnderlyingMethod = dzlCanCombine();
  NSLog(@"scroll view ended decelerating (%zd)", hasUnderlyingMethod);
}

@end

@implementation_combine(DZLViewController, Example2)

- (void)viewDidLoad
{
  NSLog(@"in even more combined viewDidLoad");
  
  dzlSuper(viewDidLoad);
}

@end
