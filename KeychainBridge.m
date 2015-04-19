//
//  KeychainBridge.m
//  AnyGif
//
//  Created by Dave on 4/19/15.
//  Copyright (c) 2015 Facebook. All rights reserved.
//

#import "KeychainBridge.h"
#import "FXKeychain.h"
#import "RCTLog.h"

@implementation KeychainBridge

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(setObjectsAndKeys:(NSDictionary *)objects) {
  [objects enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
    [[FXKeychain defaultKeychain] setObject:obj forKey:key];
    RCTLog([NSString stringWithFormat:@"set %@: %@", obj, key]);
  }];
}

RCT_EXPORT_METHOD(getObjectForKey:(id)key callback:(RCTResponseSenderBlock)callback) {
  id result = [[FXKeychain defaultKeychain] objectForKey:key];
  if (result) {
    callback(@[[NSNull null], result]);
    RCTLog([NSString stringWithFormat:@"get %@: %@", key, result]);
  } else {
    callback(@[@"missing key"]);
    RCTLog(@"Missing key");
  }
}

@end
