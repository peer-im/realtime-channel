//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/retechretech/dev/workspace/realtime/realtime-channel/src/main/java/com/goodow/realtime/objc/ObjCSimpleBus.java
//
//  Created by retechretech.
//

#include "com/goodow/realtime/core/Handler.h"
#include "com/goodow/realtime/objc/ObjCSimpleBus.h"
#import "GDChannel.h"

@implementation ComGoodowRealtimeObjcObjCSimpleBus

+ (void)handleWithId:(id)message
              withId:(id)handler {
  if ([handler conformsToProtocol: @protocol(ComGoodowRealtimeCoreHandler)]) {
    [((id<ComGoodowRealtimeCoreHandler>) check_protocol_cast(handler, @protocol(ComGoodowRealtimeCoreHandler))) handleWithId:message];
  }
  else {
    [ComGoodowRealtimeObjcObjCSimpleBus _nativeHandleWithId:message withId:handler];
  }
}

+ (void)_nativeHandleWithId:(id)message
                     withId:(id)handler {
  GDCMessageBlock block = (GDCMessageBlock)handler;
  block(message);
}

- (void)nativeHandleWithId:(id)message
                    withId:(id)handler {
  [ComGoodowRealtimeObjcObjCSimpleBus handleWithId:message withId:handler];
}

- (id)init {
  return [super init];
}

+ (J2ObjcClassInfo *)__metadata {
  static J2ObjcMethodInfo methods[] = {
    { "handleWithId:withId:", NULL, "V", 0xc, NULL },
    { "_nativeHandleWithId:withId:", NULL, "V", 0x10a, NULL },
    { "nativeHandleWithId:withId:", NULL, "V", 0x4, NULL },
  };
  static J2ObjcClassInfo _ComGoodowRealtimeObjcObjCSimpleBus = { "ObjCSimpleBus", "com.goodow.realtime.objc", NULL, 0x1, 3, methods, 0, NULL, 0, NULL};
  return &_ComGoodowRealtimeObjcObjCSimpleBus;
}

@end
