//
//  EXKTag.m
//  ExchangeKit
//
//  Created by Robert Widmann on 6/19/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "EXKTag.h"

@implementation EXKTag

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return @{
		 @"name" : @"name",
		 @"count" : @"count",
		 @"hasSynonyms" : @"has_synonyms"
	 };
}

+ (NSValueTransformer *)hasSynonymsJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLBooleanValueTransformerName];
}

- (void)setNilValueForKey:(NSString *)key {
	if ([key isEqualToString:@"hasSynonyms"]) {
		return;
	}
	[super setNilValueForKey:key];
}

@end
