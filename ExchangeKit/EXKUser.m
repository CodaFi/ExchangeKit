//
//  EXKUser.m
//  ExchangeKit
//
//  Created by Robert Widmann on 6/19/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "EXKUser.h"

@implementation EXKUserBadgeCounts

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return @{
			 @"goldBadgeCount" : @"gold",
			 @"silverBadgeCount" : @"silver",
			 @"bronzeBadgeCount" : @"bronze"
	};
}

@end

@implementation EXKUser

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
	return @{
			 @"userID" : @"user_id",
			 @"accountID" : @"account_id",
			 @"userType" : @"user_type",
			 @"creationDate" : @"creation_date",
			 @"displayName" : @"display_name",
			 @"profileImageURL" : @"profile_image",
			 @"reputation" : @"reputation",
			 @"reputationChangeDay" : @"reputation_change_day",
			 @"reputationChangeWeek" : @"reputation_change_week",
			 @"reputationChangeMonth" : @"reputation_change_month",
			 @"reputationChangeQuarter" : @"reputation_change_quarter",
			 @"reputationChangeYear" : @"reputation_change_year",
			 @"age" : @"age",
			 @"lastAccessDate" : @"last_access_date",
			 @"lastModifiedDate" : @"last_modified_date",
			 @"isEmployee" : @"is_employee",
			 @"profileURLString" : @"link",
			 @"websiteURLString" : @"website_url",
			 @"location" : @"location",
			 @"badgeCounts" : @"badge_counts",
			 @"acceptRate" : @"accept_rate",
	};
}

+ (NSValueTransformer *)userTypeJSONTransformer {
	NSDictionary *actionTypes = @{
		NSNull.null : @(EXKUserTypeNone),
		@"registered" : @(EXKUserTypeRegistered),
		@"unregistered" : @(EXKUserTypeUnregistered),
	};
	
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSString *str) {
		if (!str) return @(EXKUserTypeNone);
        return (NSNumber *)actionTypes[str];
    } reverseBlock:^(NSNumber *state) {
        return [actionTypes allKeysForObject:state].lastObject;
    }];
}

+ (NSValueTransformer *)badgeCountsJSONTransformer {
    return [MTLValueTransformer mtl_JSONDictionaryTransformerWithModelClass:EXKUserBadgeCounts.class];
}

+ (NSValueTransformer *)createdAtJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSNumber *unixEpochTime) {
        return [NSDate dateWithTimeIntervalSince1970:unixEpochTime.longLongValue];
    } reverseBlock:^(NSDate *date) {
        return @([date timeIntervalSince1970]);
    }];
}

+ (NSValueTransformer *)lastAccessDateJSONTransformer {
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

+ (NSValueTransformer *)profileImageURLJSONTransformer {
	return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}

@end
