//
//  EXKObject.h
//  ExchangeKit
//
//  Created by Robert Widmann on 6/19/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import <Mantle/Mantle.h>

@class EXKServer;

@interface EXKObject : MTLModel <MTLJSONSerializing>

@property (weak, readonly) EXKServer *site;

@end
