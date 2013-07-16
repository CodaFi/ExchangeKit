//
//  EXKClient.m
//  ExchangeKit
//
//  Created by Robert Widmann on 6/19/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "EXKClient.h"
#import "EXKUser.h"
#import "EXKJSONRequestOperation.h"
#import "EXKKeychain.h"

static NSString *const EXKWebAuthRedirectURI = @"https://stackexchange.com/oauth/login_success";

@interface EXKClient ()

@property (strong) AFHTTPClient *authHTTPClient;
@property (readwrite, strong) EXKUser *authenticatedUser;

- (void)initializeHTTPAuthClient;
- (void)HTTPAuthDidCompleteSuccessfully:(BOOL)wasSuccessful error:(NSError *)error handler:(void (^)(BOOL successful, NSError *error))handler;
- (void)authenticateWithParameters:(NSDictionary *)params handler:(void (^)(BOOL successful, NSError *error))handler;

@end

@implementation EXKClient

#pragma mark - Lifecycle

+ (instancetype)sharedClient {
    static EXKClient *sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedClient = [[EXKClient alloc] init];
    });
    return sharedClient;
}

+ (NSURL *)APIBaseURL {
	return [NSURL URLWithString:@"https://api.stackexchange.com/2.1/"];
}

- (id)init {
    if ((self = [super initWithBaseURL:[[self class] APIBaseURL]])) {
		self.parameterEncoding = AFJSONParameterEncoding;
		[self setDefaultHeader:@"Accept" value:@"application/json"];
		[self registerHTTPOperationClass:[EXKJSONRequestOperation class]];
		
		[self addObserver:self forKeyPath:@"accessToken" options:NSKeyValueObservingOptionNew context:nil];
		self.accessToken = EXKKeychain.defaultKeychain[@"accessToken"];
		self.apiKey = EXKKeychain.defaultKeychain[@"apiKey"];
	}
    
    return self;
}


- (void)dealloc {
	[self removeObserver:self forKeyPath:@"accessToken"];
}

- (id)copyWithZone:(NSZone *)zone {
	EXKClient *copy = [[[self class] alloc] init];
	
	copy.accessToken = [self.accessToken copyWithZone:zone];
	copy.authenticatedUser = [self.authenticatedUser copyWithZone:zone];
	
	return copy;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
	if ([keyPath isEqualToString:@"accessToken"]) {
		EXKKeychain.defaultKeychain[@"accessToken"] = self.accessToken;
		EXKKeychain.defaultKeychain[@"apiKey"] = self.apiKey;
	}
}

#pragma mark - Authentication

- (NSURLRequest *)webAuthRequestForClientID:(NSString *)clientID authScopes:(EXKAuthScope)authScopes state:(NSString *)state {
	// http://api.stackexchange.com/docs/authentication
	NSMutableString *URLString = [NSMutableString stringWithFormat:@"https://stackexchange.com/oauth/dialog?client_id=%@", clientID];
	
	if (authScopes) {
		[URLString appendFormat:@"&scope=%@", EXKScopeStringForAuthScopes(authScopes)];
	}
	
	[URLString appendFormat:@"&redirect_uri=https://stackexchange.com/oauth/login_success"];
	
	if (state) {
		[URLString appendFormat:@"&state=%@", state];
	}
	
	NSURL *URL = [NSURL URLWithString:URLString];
	return [NSURLRequest requestWithURL:URL cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:60];
}

- (void)authenticateUserWithAccessToken:(NSString *)accessToken ClientID:(NSString *)clientID key:(NSString *)key {
	// http://developers.app.net/docs/authentication/flows/web/
	NSDictionary *parameters = @{
								 @"site" : @"stackoverflow",
								 @"client_id": clientID,
								 @"access_token" : accessToken,
								 @"key": key
								 };
	[self authenticateWithParameters:parameters handler:self.webAuthCompletionHandler];
}

#pragma mark - Internal API

- (void)initializeHTTPAuthClient {
	self.authHTTPClient = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:@"https://api.stackexchange.com/2.1/"]];
	self.authHTTPClient.parameterEncoding = AFFormURLParameterEncoding;
	[self.authHTTPClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
}


- (void)authenticateWithParameters:(NSDictionary *)params handler:(void (^)(BOOL successful, NSError *error))handler {
	[self initializeHTTPAuthClient];
	[self.authHTTPClient getPath:@"me" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
		if (params[@"access_token"]) {
			self.accessToken = params[@"access_token"];
			self.apiKey = params[@"key"];
			[self HTTPAuthDidCompleteSuccessfully:YES error:nil handler:handler];
		} else {
			NSError *error = [NSError errorWithDomain:EXKErrorDomain code:-1 userInfo:@{NSLocalizedDescriptionKey: @"Could not find key access_token in response", NSLocalizedFailureReasonErrorKey: responseDictionary}];
			[self HTTPAuthDidCompleteSuccessfully:NO error:error handler:handler];
		}
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		[self HTTPAuthDidCompleteSuccessfully:NO error:error handler:handler];
	}];
}


- (void)HTTPAuthDidCompleteSuccessfully:(BOOL)wasSuccessful error:(NSError *)error handler:(void (^)(BOOL successful, NSError *error))handler {
	if (error.localizedRecoverySuggestion) {
		NSDictionary *errorDictionary = [NSJSONSerialization JSONObjectWithData:[error.localizedRecoverySuggestion dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
		if (errorDictionary) {
			NSError *modifiedError = [NSError errorWithDomain:EXKErrorDomain code:0 userInfo:@{NSLocalizedDescriptionKey: errorDictionary[@"error"]}];
			error = modifiedError;
		}
	}
	if (handler) {
		handler(wasSuccessful, error);
	}
	
	self.authHTTPClient = nil;
	self.webAuthCompletionHandler = nil;
}


@end
