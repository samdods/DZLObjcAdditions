//
//  NSObject+DZLMixinProtocol.h
//  MixinExample
//
//  Created by Sam Dods on 15/05/2014.
//  Copyright (c) 2014 Sam Dods. All rights reserved.
//


#define protocol_implementation(name) \
interface MixinProtocol_ ## name : NSObject <name> @end \
@implementation MixinProtocol_ ## name \
