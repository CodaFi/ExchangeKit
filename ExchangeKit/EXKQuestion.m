//
//  EXKQuestion.m
//  ExchangeKit
//
//  Created by Robert Widmann on 6/19/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "EXKQuestion.h"
#import "EXKUser.h"
#import "EXKTag.h"

@implementation EXKQuestion

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return @{
		@"questionID" : @"question_id",
		@"lastEditDate" : @"last_edit_date",
		@"creationDate" : @"creation_date",
		@"lastActivityDate" : @"last_activity_date",
		@"answerCount" : @"answer_count",
		@"body" : @"body",
		@"title" : @"title",
		@"tags" : @"tags",
		@"score" : @"score",
		@"upvoteCount" : @"upvote_count",
		@"downvoteCount" : @"downvote_count",
		@"favoriteCount" : @"favorite_count",
		@"viewCount" : @"view_count",
		@"owner" : @"owner",
		@"link" : @"link",
		@"isAnswered" : @"is_answered",
	};
}

+ (NSValueTransformer *)ownerJSONTransformer {
    return [MTLValueTransformer mtl_JSONDictionaryTransformerWithModelClass:EXKUser.class];
}


+ (NSValueTransformer *)creationDateJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *unixEpochTime) {
        return [NSDate dateWithTimeIntervalSince1970:unixEpochTime.longLongValue];
    } reverseBlock:^(NSDate *date) {
        return @([date timeIntervalSince1970]);
    }];
}

+ (NSValueTransformer *)lastEditDateJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *unixEpochTime) {
        return [NSDate dateWithTimeIntervalSince1970:unixEpochTime.longLongValue];
    } reverseBlock:^(NSDate *date) {
        return @([date timeIntervalSince1970]);
    }];
}

+ (NSValueTransformer *)lastModifiedDateJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *unixEpochTime) {
        return [NSDate dateWithTimeIntervalSince1970:unixEpochTime.longLongValue];
    } reverseBlock:^(NSDate *date) {
        return @([date timeIntervalSince1970]);
    }];
}

+ (NSValueTransformer *)lastActivityDateJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *unixEpochTime) {
        return [NSDate dateWithTimeIntervalSince1970:unixEpochTime.longLongValue];
    } reverseBlock:^(NSDate *date) {
        return @([date timeIntervalSince1970]);
    }];
}

+ (NSValueTransformer *)linkJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

+ (NSValueTransformer *)isAnsweredJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

- (void)setNilValueForKey:(NSString *)key {
	if ([key isEqualToString:@"isAnswered"]) {
		return;
	}
	[super setNilValueForKey:key];
}

@end
