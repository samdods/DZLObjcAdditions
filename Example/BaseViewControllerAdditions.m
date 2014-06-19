//
//  BaseViewControllerAdditions.m
//  Example
//
//  Created by Sam Dods on 19/06/2014.
//  Copyright (c) 2014 Sam Dods. All rights reserved.
//

#import "BaseViewController.h"
#import "DZLImplementationCombine.h"


@implementation_combine(BaseViewController, Additions)

- (void)viewDidLoad
{
  dzlSuper(viewDidLoad);
}

@end



@implementation_combine(RootViewController, Additions)

- (void)viewDidLoad
{
  dzlSuper(viewDidLoad);
}

- (void)viewWillAppear:(BOOL)animated
{
  dzlSuper(viewWillAppear:animated);
}

@end
