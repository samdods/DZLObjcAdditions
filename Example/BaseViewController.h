//
//  BaseViewController.h
//  Example
//
//  Created by Sam Dods on 13/05/2014.
//  Copyright (c) 2014 Sam Dods. All rights reserved.
//

#import "RootViewController.h"

@interface BaseViewController : RootViewController

- (BOOL)isSomething;

- (void)viewDidLoad NS_REQUIRES_SUPER;
- (void)viewWillAppear:(BOOL)animated NS_REQUIRES_SUPER;
- (void)viewDidAppear:(BOOL)animated NS_REQUIRES_SUPER;

@end
