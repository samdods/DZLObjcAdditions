//
//  NSObject+DZLMixinProtocol.h
//  MixinExample
//
//  Created by Sam Dods on 15/05/2014.
//  Copyright (c) 2014 Sam Dods. All rights reserved.
//

#import <Foundation/Foundation.h>


#define protocol_implementation(name) \
interface name ## MixinProtocol_ : NSObject <name> @end \
@implementation name ## MixinProtocol_ \


@interface NSObject (DZLMixin)

+ (void)mixinProtocol:(Protocol *)mixinProtocol;

@end