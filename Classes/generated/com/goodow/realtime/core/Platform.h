//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/retechretech/dev/workspace/realtime/realtime-channel/src/main/java/com/goodow/realtime/core/Platform.java
//
//  Created by retechretech.
//

#ifndef _ComGoodowRealtimeCorePlatform_H_
#define _ComGoodowRealtimeCorePlatform_H_

@class ComGoodowRealtimeCorePlatform_TypeEnum;
@class ComGoodowRealtimeCoreVoidHandler;
@protocol ComGoodowRealtimeCoreNet;

#import "JreEmulation.h"
#include "java/lang/Enum.h"

@interface ComGoodowRealtimeCorePlatform : NSObject {
}

+ (ComGoodowRealtimeCorePlatform *)platform;
+ (void)setPlatform:(ComGoodowRealtimeCorePlatform *)platform;
+ (ComGoodowRealtimeCorePlatform *)get;
+ (void)setPlatformWithComGoodowRealtimeCorePlatform:(ComGoodowRealtimeCorePlatform *)platform;
- (id)init;
- (BOOL)cancelTimerWithInt:(int)id_;
- (id<ComGoodowRealtimeCoreNet>)net;
- (void)scheduleDeferredWithComGoodowRealtimeCoreVoidHandler:(ComGoodowRealtimeCoreVoidHandler *)handler;
- (int)setPeriodicWithInt:(int)delayMs
withComGoodowRealtimeCoreVoidHandler:(ComGoodowRealtimeCoreVoidHandler *)handler;
- (ComGoodowRealtimeCorePlatform_TypeEnum *)type;
@end

typedef enum {
  ComGoodowRealtimeCorePlatform_Type_JAVA = 0,
  ComGoodowRealtimeCorePlatform_Type_HTML = 1,
  ComGoodowRealtimeCorePlatform_Type_ANDROID = 2,
  ComGoodowRealtimeCorePlatform_Type_IOS = 3,
  ComGoodowRealtimeCorePlatform_Type_FLASH = 4,
  ComGoodowRealtimeCorePlatform_Type_STUB = 5,
} ComGoodowRealtimeCorePlatform_Type;

@interface ComGoodowRealtimeCorePlatform_TypeEnum : JavaLangEnum < NSCopying > {
}
+ (ComGoodowRealtimeCorePlatform_TypeEnum *)JAVA;
+ (ComGoodowRealtimeCorePlatform_TypeEnum *)HTML;
+ (ComGoodowRealtimeCorePlatform_TypeEnum *)ANDROID;
+ (ComGoodowRealtimeCorePlatform_TypeEnum *)IOS;
+ (ComGoodowRealtimeCorePlatform_TypeEnum *)FLASH;
+ (ComGoodowRealtimeCorePlatform_TypeEnum *)STUB;
+ (IOSObjectArray *)values;
+ (ComGoodowRealtimeCorePlatform_TypeEnum *)valueOfWithNSString:(NSString *)name;
- (id)copyWithZone:(NSZone *)zone;
- (id)initWithNSString:(NSString *)__name withInt:(int)__ordinal;
@end

#endif // _ComGoodowRealtimeCorePlatform_H_
