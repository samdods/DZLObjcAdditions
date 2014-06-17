//
//  BaseViewController.h
//  MixinExample
//
//  Created by Sam Dods on 13/05/2014.
//  Copyright (c) 2014 Sam Dods. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

- (BOOL)isSomething;

- (void)viewDidLoad NS_REQUIRES_SUPER;
- (void)viewWillAppear:(BOOL)animated NS_REQUIRES_SUPER;
- (void)viewDidAppear:(BOOL)animated NS_REQUIRES_SUPER;

@end
