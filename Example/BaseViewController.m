//
//  BaseViewController.m
//  MixinExample
//
//  Created by Sam Dods on 13/05/2014.
//  Copyright (c) 2014 Sam Dods. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
}

- (BOOL)isSomething
{
  return YES;
}

@end
