//
//  EXKFetchRequest.h
//  ExchangeKit
//
//  Created by Robert Widmann on 6/19/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import <CoreData/CoreData.h>

@class EXKServer;

@interface EXKFetchRequest : NSFetchRequest

@property (nonatomic, strong) NSString *method;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) EXKServer *server;

@end
