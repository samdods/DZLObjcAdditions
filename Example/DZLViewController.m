//
//  DZLViewController.m
//  MixinExample
//
//  Created by Sam Dods on 13/05/2014.
//  Copyright (c) 2014 Sam Dods. All rights reserved.
//

#import "DZLViewController.h"
#import "DZLViewControllerMixin.h"

@interface DZLViewController () <TestProtocol>

@end

@implementation DZLViewController

+ (void)load
{
  
}

+ (BOOL)shouldDoSomethingWithObject:(id)object
{
  return object != nil;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self doSomethingMagic];
  
  BOOL should1 = [self.class shouldDoSomethingWithObject:nil];
  BOOL should2 = [self.class shouldDoSomethingWithObject:self];
  BOOL isSomething = [self isSomething];
  
  NSLog(@"%d %d %d", should1, should2, isSomething);
}

@end
