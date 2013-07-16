//
//  EXKAPIResponse.h
//  ExchangeKit
//
//  Created by Robert Widmann on 6/19/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "EXKObject.h"

@interface EXKAPIResponse : EXKObject

@property (readonly, strong) id data;

- (id)initWithResponseObject:(id)responseObject;

@end
