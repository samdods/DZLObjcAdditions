//
//  DZLViewController.m
//  Example
//
//  Created by Sam Dods on 13/05/2014.
//  Copyright (c) 2014 Sam Dods. All rights reserved.
//

#import "DZLViewController.h"
#import "DZLViewControllerAdditions.h"
#import "DZLSynthesizeLazy.h"
#import "DZLClassSingleton.h"

@interface DZLViewController () <TestProtocol, TestProtocol2>
@property (nonatomic, strong) NSOperationQueue *operationQueue;
@property (nonatomic, strong) NSMutableArray *myObjects;
@end


@implementation DZLViewController

@class_singleton_setup(DZLViewController, sharedInstance,
  sharedInstance.operationQueue = [NSOperationQueue new];
  sharedInstance.operationQueue.maxConcurrentOperationCount = 1;
)

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
  [self doSomethingElseMagic];
  
  BOOL should1 = [self.class shouldDoSomethingWithObject:nil];
  BOOL should2 = [self.class shouldDoSomethingWithObject:self];
  BOOL isSomething = [self isSomething];
  
  NSLog(@"%d %d %d", should1, should2, isSomething);
  
  NSLog(@"%@", self.class.sharedInstance.myObjects);
}

- (void)doSomethingElseMagic
{
  NSLog(@"in implemented doSomethingElseMagic");
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
  
}

@end
