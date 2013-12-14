//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/retechretech/dev/workspace/realtime/realtime-channel/src/main/java/com/goodow/realtime/channel/impl/DefaultMessage.java
//
//  Created by retechretech.
//

#include "IOSClass.h"
#include "com/goodow/realtime/channel/Bus.h"
#include "com/goodow/realtime/channel/impl/DefaultMessage.h"
#include "com/goodow/realtime/core/Handler.h"
#include "com/goodow/realtime/json/JsonElement.h"

@implementation ComGoodowRealtimeChannelImplDefaultMessage

- (id)initWithBoolean:(BOOL)send
           withGDCBus:(id<GDCBus>)bus
         withNSString:(NSString *)address
         withNSString:(NSString *)replyAddress
               withId:(id)body {
  if (self = [super init]) {
    self->send_ = send;
    self->bus_ = bus;
    self->address__ = address;
    self->replyAddress__ = replyAddress;
    self->body__ = body;
  }
  return self;
}

- (NSString *)address {
  return address__;
}

- (id)body {
  return body__;
}

- (void)fail:(int)failureCode message:(NSString *)msg {
}

- (void)reply:(id<GDJsonElement>)msg {
  [self sendReplyWithGDJsonElement:msg withComGoodowRealtimeCoreHandler:nil];
}

- (void)reply:(id<GDJsonElement>)msg replyHandler:(id)replyHandler {
  [self sendReplyWithGDJsonElement:msg withComGoodowRealtimeCoreHandler:replyHandler];
}

- (NSString *)replyAddress {
  return replyAddress__;
}

- (NSString *)description {
  return body__ == nil ? nil : [body__ description];
}

- (void)sendReplyWithGDJsonElement:(id<GDJsonElement>)msg
  withComGoodowRealtimeCoreHandler:(id<ComGoodowRealtimeCoreHandler>)replyHandler {
  if (bus_ != nil && replyAddress__ != nil) {
    (void) [bus_ send:replyAddress__ message:msg replyHandler:replyHandler];
  }
}

- (void)copyAllFieldsTo:(ComGoodowRealtimeChannelImplDefaultMessage *)other {
  [super copyAllFieldsTo:other];
  other->address__ = address__;
  other->body__ = body__;
  other->bus_ = bus_;
  other->replyAddress__ = replyAddress__;
  other->send_ = send_;
}

+ (J2ObjcClassInfo *)__metadata {
  static J2ObjcMethodInfo methods[] = {
    { "address", NULL, "LNSString", 0x1, NULL },
    { "body", NULL, "TU", 0x1, NULL },
    { "replyAddress", NULL, "LNSString", 0x1, NULL },
    { "sendReplyWithGDJsonElement:withComGoodowRealtimeCoreHandler:", NULL, "V", 0x2, NULL },
  };
  static J2ObjcFieldInfo fields[] = {
    { "body__", "body", 0x4, "TU" },
    { "bus_", NULL, 0x4, "LGDCBus" },
    { "address__", "address", 0x4, "LNSString" },
    { "replyAddress__", "replyAddress", 0x4, "LNSString" },
    { "send_", NULL, 0x4, "Z" },
  };
  static J2ObjcClassInfo _ComGoodowRealtimeChannelImplDefaultMessage = { "DefaultMessage", "com.goodow.realtime.channel.impl", NULL, 0x1, 4, methods, 5, fields, 0, NULL};
  return &_ComGoodowRealtimeChannelImplDefaultMessage;
}

@end
