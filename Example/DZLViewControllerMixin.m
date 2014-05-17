//
//  DZLViewControllerMixin.h
//  MixinExample
//
//  Created by Sam Dods on 14/05/2014.
//  Copyright (c) 2014 Sam Dods. All rights reserved.
//

#import "DZLCategoryCombine.h"
#import "DZLCategorySafe.h"
#import "DZLMixinProtocol.h"
#import "DZLViewControllerMixin.h"

@protocol_implementation(TestProtocol)

- (void)doSomethingMagic
{
  
}

@end


@implementation_safe(DZLViewController, Example)

- (void)viewWillAppear:(BOOL)animated
{
  safeSuper(animated);
}

- (BOOL)isSomething
{
  BOOL isSomething = (BOOL)safeSuper();
  return isSomething;
}

@end


@implementation_combine(DZLViewController, Example)

+ (BOOL)shouldDoSomethingWithObject:(id)object
{
  NSLog(@"before should");
  
  BOOL should = (BOOL)combineOriginal(object);
  
  NSLog(@"after should");
  
  return should;
}

- (void)viewDidLoad
{
  NSLog(@"before");
  
  combineOriginal();

  NSLog(@"after");
}

@end

@implementation_combine(DZLViewController, Example2)

- (void)viewDidLoad
{
  NSLog(@"before2");
  
  combineOriginal();
  
  NSLog(@"after2");
}

@end
