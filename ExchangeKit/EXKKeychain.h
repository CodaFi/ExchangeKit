//
//  EXKKeychain.h
//  ExchangeKit
//
//  Created by Robert Widmann on 6/19/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EXKKeychain : NSObject

@property (nonatomic, copy, readonly) NSString *service;

+ (instancetype)defaultKeychain;
- (BOOL)setObject:(id)object forKey:(id<NSObject, NSCopying>)key;
- (id)objectForKey:(id<NSCopying>)key;
- (BOOL)removeObjectForKey:(id<NSCopying>)key;

@end

#if __has_feature(objc_subscripting)

@interface EXKKeychain (EXKSubscripting)

- (BOOL)setObject:(id)object forKeyedSubscript:(id)key;
- (id)objectForKeyedSubscript:(id)key;

@end

#endif