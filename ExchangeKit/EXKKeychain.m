//
//  EXKKeychain.m
//  ExchangeKit
//
//  Created by Robert Widmann on 6/19/13.
//  Copyright (c) 2013 CodaFi. All rights reserved.
//

#import "EXKKeychain.h"

@implementation EXKKeychain

+ (instancetype)defaultKeychain {
    static EXKKeychain *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[EXKKeychain alloc] initWithBundle:NSBundle.mainBundle];
    });
    return sharedInstance;
}

- (id)initWithBundle:(NSBundle *)bundle
{
	self = [super init];
	_service = [bundle.infoDictionary[(NSString *)kCFBundleIdentifierKey] copy];
    return self;
}

- (NSData *)dataForKey:(id)key {
    NSMutableDictionary *query = [NSMutableDictionary dictionary];
    if ([_service length]) query[(NSString *)kSecAttrService] = _service;
    query[(NSString *)kSecClass] = (id)kSecClassGenericPassword;
    query[(NSString *)kSecMatchLimit] = (id)kSecMatchLimitOne;
    query[(NSString *)kSecReturnData] = (id)kCFBooleanTrue;
    query[(NSString *)kSecAttrAccount] = [key description];
    
    CFTypeRef data = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, &data);
	if (status != errSecSuccess && status != errSecItemNotFound) {
		NSLog(@"SecItemCopyMatching: errSecItemNotFound");
	}
	return CFBridgingRelease(data);
}

- (BOOL)setObject:(id)object forKey:(id<NSObject, NSCopying>)key {
    NSParameterAssert(key);
	
    //generate query
    NSMutableDictionary *query = [NSMutableDictionary dictionary];
    if ([_service length]) query[(NSString *)kSecAttrService] = _service;
    query[(NSString *)kSecClass] = (id)kSecClassGenericPassword;
    query[(NSString *)kSecAttrAccount] = [key description];
    
    //encode object
    NSData *data = nil;
    NSError *error = nil;
    if ([(id)object isKindOfClass:[NSString class]])
    {
        //check that string data does not represent a binary plist
        NSPropertyListFormat format = NSPropertyListBinaryFormat_v1_0;
        NSData *plistData = [object dataUsingEncoding:NSUTF8StringEncoding];
        if (plistData && ([NSPropertyListSerialization propertyListWithData:plistData options:NSPropertyListImmutable format:&format error:NULL] == nil || format != NSPropertyListBinaryFormat_v1_0))
        {
            //safe to encode as a string
            data = [object dataUsingEncoding:NSUTF8StringEncoding];
        }
    }
    
    //if not encoded as a string, encode as plist
    if (object && !data)
    {
        data = [NSPropertyListSerialization dataWithPropertyList:object
                                                          format:NSPropertyListBinaryFormat_v1_0
                                                         options:0
                                                           error:&error];
    }
	
    //fail if object is invalid
    NSAssert(!object || (object && data), @"");
	
    if (data) {
		OSStatus status = errSecSuccess;
		if ([self dataForKey:key]) {
			NSDictionary *update = @{(__bridge NSString *)kSecValueData: data};
			status = SecItemUpdate((__bridge CFDictionaryRef)query, (__bridge CFDictionaryRef)update);
		} else {
			query[(__bridge NSString *)kSecValueData] = data;
			status = SecItemAdd ((__bridge CFDictionaryRef)query, NULL);
		}
        if (status != errSecSuccess) {
            return NO;
        }
    } else {
        //delete existing data
        
#if defined __IPHONE_OS_VERSION_MAX_ALLOWED
        
        OSStatus status = SecItemDelete((__bridge CFDictionaryRef)query);
#else
        CFTypeRef result = NULL;
        query[(__bridge id)kSecReturnRef] = (__bridge id)kCFBooleanTrue;
        OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, &result);
        if (status == errSecSuccess)
        {
            status = SecKeychainItemDelete((SecKeychainItemRef) result);
            CFRelease(result);
        }
#endif
        if (status != errSecSuccess) {
            return NO;
        }
    }
    return YES;
}

- (BOOL)setObject:(id)object forKeyedSubscript:(id)key {
    return [self setObject:object forKey:key];
}

- (BOOL)removeObjectForKey:(id)key {
    return [self setObject:nil forKey:key];
}

- (id)objectForKey:(id)key
{
    NSData *data = [self dataForKey:key];
    if (data)
    {
        NSError *error = nil;
        NSPropertyListFormat format = 0;
        id object;
        if ([NSPropertyListSerialization respondsToSelector:@selector(propertyListWithData:options:format:error:)]) {
            object = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:&format error:&error];
        }
        else {
            object = [NSPropertyListSerialization propertyListFromData:data mutabilityOption:NSPropertyListImmutable format:&format errorDescription:NULL];
        }
        
        if ([object respondsToSelector:@selector(objectForKey:)] && object[@"$archiver"]) {
            object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
		if (!object) {
			object = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
		}
        return object;
    }
	return data;
}

- (id)objectForKeyedSubscript:(id)key {
    return [self objectForKey:key];
}

@end
