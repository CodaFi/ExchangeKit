//
//  EXKFetchRequest.m
//  ExchangeKit
//
//  Created by Robert Widmann on 6/19/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "EXKFetchRequest.h"

NSUInteger const SKPageSizeLimitMax = 100;

@interface EXKFetchRequest ()

@property (nonatomic, assign) Class modelObjectClass;

@end

@implementation EXKFetchRequest

+ (NSFetchRequest *)fetchRequestWithEntityName:(NSString *)entityName {
	return [[self.class alloc] initWithEntityName:entityName];
}

- (id)init {
	self = [super init];
	
	self.fetchLimit = SKPageSizeLimitMax;
	self.fetchOffset = 0;
	
	return self;
}

- (id) initWithEntityName:(NSString *)entityName {
	self = [super initWithEntityName:entityName];
	
	self.modelObjectClass = NSClassFromString(entityName);
	self.fetchLimit = SKPageSizeLimitMax;
	self.fetchOffset = 0;
	
	return self;
}

- (void)setEntity:(NSEntityDescription *)entity {
	
}

- (void) setFetchLimit:(NSUInteger)newLimit {
	if (newLimit > SKPageSizeLimitMax) {
		newLimit = SKPageSizeLimitMax;
	}
	[super setFetchLimit:newLimit];
}

- (NSFetchRequestResultType)requestType {
	return NSManagedObjectResultType;
}

@end
