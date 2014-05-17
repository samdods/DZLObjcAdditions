//
//  DZLViewControllerMixin.h
//  MixinExample
//
//  Created by Sam Dods on 14/05/2014.
//  Copyright (c) 2014 Sam Dods. All rights reserved.
//

#import "DZLViewController.h"

@protocol TestProtocol

@optional

- (void)doSomethingMagic;

@end

@interface DZLViewController (Example)
@end


