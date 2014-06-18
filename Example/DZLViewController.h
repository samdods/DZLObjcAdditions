//
//  DZLViewController.h
//  Example
//
//  Created by Sam Dods on 13/05/2014.
//  Copyright (c) 2014 Sam Dods. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface DZLViewController : BaseViewController <UIScrollViewDelegate>

+ (DZLViewController *)sharedInstance;

+ (BOOL)shouldDoSomethingWithObject:(id)object;

@end
