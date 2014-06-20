//
//  BaseViewController.m
//  Example
//
//  Created by Sam Dods on 13/05/2014.
//  Copyright (c) 2014 Sam Dods. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)dealloc
{
  BOOL isSomething = [self isSomething];
  
  NSLog(@"in dealloc, isSomething: %@", isSomething ? @"YES" : @"NO");
}

- (void)viewDidLoad
{
  [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
}

- (BOOL)isSomething
{
  return YES;
}

@end
