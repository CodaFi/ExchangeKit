//
//  EXKUser.h
//  ExchangeKit
//
//  Created by Robert Widmann on 6/19/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "EXKObject.h"

typedef NS_ENUM(NSUInteger, EXKUserType) {
	EXKUserTypeNone,
	EXKUserTypeRegistered,
	EXKUserTypeUnregistered
};

@interface EXKUserBadgeCounts : EXKObject

@property (nonatomic, copy) NSNumber *goldBadgeCount;
@property (nonatomic, copy) NSNumber *silverBadgeCount;
@property (nonatomic, copy) NSNumber *bronzeBadgeCount;

@end

@interface EXKUser : EXKObject

@property (nonatomic, copy) NSNumber *userID;
@property (nonatomic, copy) NSNumber *accountID;
@property (nonatomic) EXKUserType userType;
@property (nonatomic, copy) NSDate *creationDate;
@property (nonatomic, copy) NSString *displayName;
@property (nonatomic, copy) NSURL *profileImageURL;
@property (nonatomic, copy) NSNumber *reputation;

@property (nonatomic, copy) NSNumber *reputationChangeDay;
@property (nonatomic, copy) NSNumber *reputationChangeWeek;
@property (nonatomic, copy) NSNumber *reputationChangeMonth;
@property (nonatomic, copy) NSNumber *reputationChangeQuarter;
@property (nonatomic, copy) NSNumber *reputationChangeYear;

@property (nonatomic, copy) NSNumber *age;

@property (nonatomic, copy) NSDate *lastAccessDate;
@property (nonatomic, copy) NSDate *lastModifiedDate;

@property (nonatomic) BOOL isEmployee;

@property (nonatomic, copy) NSString *profileURLString;
@property (nonatomic, copy) NSString *websiteURLString;
@property (nonatomic, copy) NSString *location;

@property (nonatomic, strong) EXKUserBadgeCounts *badgeCounts;

@property (nonatomic, copy) NSNumber *acceptRate;

@end
