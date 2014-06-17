//
//  DZLSuper.h
//  DZLObjcAdditions
//
//  Created by Sam Dods on 17/06/2014.
//  Copyright (c) 2014 Sam Dods. All rights reserved.
//

#define dzlSuper(args) \
({ if(NO) { [super args]; } \
id proxy = [DZLMixin proxyForObject:self class:self.class toForwardSelector:_cmd]; \
[proxy args]; })
