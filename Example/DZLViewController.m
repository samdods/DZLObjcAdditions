//
//  DZLViewController.m
//  MixinExample
//
//  Created by Sam Dods on 13/05/2014.
//  Copyright (c) 2014 Sam Dods. All rights reserved.
//

#import "DZLViewController.h"
#import "DZLViewControllerMixin.h"
#import "DZLSynthesizeLazy.h"
#import "DZLClassSingleton.h"

@interface DZLViewController () <TestProtocol>
@property (nonatomic, strong) NSMutableArray *myObjects;
@end

@class_singleton(DZLViewController, sharedInstance);

@implementation DZLViewController

@synthesize_lazy (NSMutableArray, myObjects);

+ (void)load
{
  [self.class.sharedInstance.myObjects addObjectsFromArray:@[@"this", @"that", @"the other"]];
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
  
  NSLog(@"%@", self.class.sharedInstance.myObjects);
}

@end
