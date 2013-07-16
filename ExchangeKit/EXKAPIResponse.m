//
//  EXKAPIResponse.m
//  ExchangeKit
//
//  Created by Robert Widmann on 6/19/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "EXKAPIResponse.h"

@interface EXKAPIResponse ()

@property (readwrite, strong) id data;

@end


@implementation EXKAPIResponse

- (id)initWithResponseObject:(id)responseObject {
	if ((self = [super init])) {
		if ([responseObject isKindOfClass:[NSDictionary class]]) {
			NSDictionary *responseDictionary = (NSDictionary *)responseObject;
			if ([responseDictionary[@"items"] count] == 1) {
				self.data = responseDictionary[@"items"][0];
			} else {
				self.data = responseDictionary[@"items"];
			}
		}
	}
	return self;
}

@end
