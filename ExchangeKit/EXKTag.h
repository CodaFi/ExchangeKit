//
//  EXKTag.h
//  ExchangeKit
//
//  Created by Robert Widmann on 6/19/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import <ExchangeKit/ExchangeKit.h>

@interface EXKTag : EXKObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *count;
@property (nonatomic) BOOL hasSynonyms;

@end
