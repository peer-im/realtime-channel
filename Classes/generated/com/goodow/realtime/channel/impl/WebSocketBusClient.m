//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/retechretech/dev/workspace/realtime/realtime-channel/src/main/java/com/goodow/realtime/channel/impl/WebSocketBusClient.java
//
//  Created by retechretech.
//

#include "IOSClass.h"
#include "com/goodow/realtime/channel/Bus.h"
#include "com/goodow/realtime/channel/Message.h"
#include "com/goodow/realtime/channel/State.h"
#include "com/goodow/realtime/channel/impl/DefaultMessage.h"
#include "com/goodow/realtime/channel/impl/SimpleBus.h"
#include "com/goodow/realtime/channel/impl/WebSocketBusClient.h"
#include "com/goodow/realtime/core/Handler.h"
#include "com/goodow/realtime/core/Net.h"
#include "com/goodow/realtime/core/Platform.h"
#include "com/goodow/realtime/core/WebSocket.h"
#include "com/goodow/realtime/json/Json.h"
#include "com/goodow/realtime/json/JsonArray.h"
#include "com/goodow/realtime/json/JsonElement.h"
#include "com/goodow/realtime/json/JsonObject.h"
#include "java/lang/IllegalStateException.h"
#include "java/util/logging/Logger.h"

@implementation ComGoodowRealtimeChannelImplWebSocketBusClient

static JavaUtilLoggingLogger * ComGoodowRealtimeChannelImplWebSocketBusClient_log_;

+ (JavaUtilLoggingLogger *)log {
  return ComGoodowRealtimeChannelImplWebSocketBusClient_log_;
}

- (id)initWithNSString:(NSString *)url
      withGDJsonObject:(id<GDJsonObject>)options {
  if (self = [super init]) {
    webSocket_ = [ComGoodowRealtimeCoreWebSocket EMPTY];
    pingTimerID_ = 0;
    webSocket_ = [((id<ComGoodowRealtimeCoreNet>) nil_chk([((ComGoodowRealtimeCorePlatform *) nil_chk([ComGoodowRealtimeCorePlatform get])) net])) createWebSocketWithNSString:url withGDJsonObject:options];
    if (options != nil) {
      pingInterval_ = (int) [options getNumber:@"vertxbus_ping_interval"];
    }
    if (pingInterval_ == 0) {
      pingInterval_ = 5 * 1000;
    }
    [((id<ComGoodowRealtimeCoreWebSocket>) nil_chk(webSocket_)) setListenWithComGoodowRealtimeCoreWebSocket_WebSocketHandler:[[ComGoodowRealtimeChannelImplWebSocketBusClient_$1 alloc] initWithComGoodowRealtimeChannelImplWebSocketBusClient:self]];
  }
  return self;
}

- (void)close {
  [self checkOpen];
  if (pingTimerID_ > 0) {
    [((ComGoodowRealtimeCorePlatform *) nil_chk([ComGoodowRealtimeCorePlatform get])) cancelTimerWithInt:pingTimerID_];
  }
  state_ = [GDCStateEnum CLOSING];
  [((id<ComGoodowRealtimeCoreWebSocket>) nil_chk(webSocket_)) close];
  [self clearHandlers];
}

- (void)login:(NSString *)username password:(NSString *)password replyHandler:(id)replyHandler {
  id<GDJsonObject> msg = [GDJson createObject];
  (void) [((id<GDJsonObject>) nil_chk(msg)) set:@"username" value:username];
  (void) [msg set:@"password" value:password];
  [self sendOrPubWithBoolean:YES withNSString:@"vertx.basicauthmanager.login" withGDJsonElement:msg withId:[[ComGoodowRealtimeChannelImplWebSocketBusClient_$2 alloc] initWithComGoodowRealtimeChannelImplWebSocketBusClient:self withComGoodowRealtimeCoreHandler:replyHandler]];
}

- (id<GDCBus>)registerHandler:(NSString *)address handler:(id)handler {
  [self checkNotNullWithNSString:@"address" withId:address];
  [self checkNotNullWithNSString:@"handler" withId:handler];
  if ([((NSString *) nil_chk(address)) charAtWithInt:0] != GDCBus_LOCAL) {
    [self checkOpen];
  }
  id<GDJsonArray> handlers = [((id<GDJsonObject>) nil_chk(handlerMap_)) getArray:address];
  if (handlers == nil) {
    handlers = [GDJson createArray];
    (void) [((id<GDJsonArray>) nil_chk(handlers)) push:handler];
    (void) [handlerMap_ set:address value:handlers];
    if ([address charAtWithInt:0] != GDCBus_LOCAL) {
      id<GDJsonObject> msg = [GDJson createObject];
      (void) [((id<GDJsonObject>) nil_chk(msg)) set:@"type" value:@"register"];
      (void) [msg set:@"address" value:address];
      [((id<ComGoodowRealtimeCoreWebSocket>) nil_chk(webSocket_)) sendWithNSString:[msg toJsonString]];
    }
  }
  else if ([handlers indexOfObject:handler] == -1) {
    (void) [handlers push:handler];
  }
  return self;
}

- (id<GDCBus>)unregisterHandler:(NSString *)address handler:(id)handler {
  [self checkNotNullWithNSString:@"address" withId:address];
  [self checkNotNullWithNSString:@"handler" withId:handler];
  if ([((NSString *) nil_chk(address)) charAtWithInt:0] != GDCBus_LOCAL) {
    [self checkOpen];
  }
  id<GDJsonArray> handlers = [((id<GDJsonObject>) nil_chk(handlerMap_)) getWithNSString:address];
  if (handlers != nil) {
    int idx = [handlers indexOfObject:handler];
    if (idx != -1) {
      (void) [handlers remove:idx];
    }
    if ([handlers count] == 0) {
      if ([address charAtWithInt:0] != GDCBus_LOCAL) {
        id<GDJsonObject> msg = [GDJson createObject];
        (void) [((id<GDJsonObject>) nil_chk(msg)) set:@"type" value:@"unregister"];
        (void) [msg set:@"address" value:address];
        [((id<ComGoodowRealtimeCoreWebSocket>) nil_chk(webSocket_)) sendWithNSString:[msg toJsonString]];
      }
      (void) [handlerMap_ remove:address];
    }
  }
  return self;
}

- (void)sendOrPubWithBoolean:(BOOL)send
                withNSString:(NSString *)address
           withGDJsonElement:(id<GDJsonElement>)msg
                      withId:(id)replyHandler {
  [self checkNotNullWithNSString:@"address" withId:address];
  if ([((NSString *) nil_chk(address)) charAtWithInt:0] == GDCBus_LOCAL) {
    [self sendOrPubLocalWithBoolean:send withNSString:[address substring:1] withGDJsonElement:msg withId:replyHandler];
    return;
  }
  [self checkOpen];
  id<GDJsonObject> envelope = [GDJson createObject];
  (void) [((id<GDJsonObject>) nil_chk(envelope)) set:@"type" value:send ? @"send" : @"publish"];
  (void) [envelope set:@"address" value:address];
  (void) [envelope set:@"body" value:msg];
  if (sessionID_ != nil) {
    (void) [envelope set:@"sessionID" value:sessionID_];
  }
  if (replyHandler != nil) {
    NSString *replyAddress = [self makeUUID];
    (void) [envelope set:@"replyAddress" value:replyAddress];
    (void) [((id<GDJsonObject>) nil_chk(replyHandlers_)) set:replyAddress value:replyHandler];
  }
  [((id<ComGoodowRealtimeCoreWebSocket>) nil_chk(webSocket_)) sendWithNSString:[envelope toJsonString]];
}

- (void)checkOpen {
  if (state_ != [GDCStateEnum OPEN]) {
    @throw [[JavaLangIllegalStateException alloc] initWithNSString:@"INVALID_STATE_ERR"];
  }
}

- (void)sendOrPubLocalWithBoolean:(BOOL)send
                     withNSString:(NSString *)address
                withGDJsonElement:(id<GDJsonElement>)msg
                           withId:(id)replyHandler {
  NSString *replyAddress = nil;
  if (replyHandler != nil) {
    replyAddress = [self makeUUID];
    (void) [((id<GDJsonObject>) nil_chk(replyHandlers_)) set:replyAddress value:replyHandler];
  }
  [self deliverMessageWithNSString:address withGDCMessage:[[ComGoodowRealtimeChannelImplDefaultMessage alloc] initWithBoolean:NO withGDCBus:self withNSString:address withNSString:replyAddress == nil ? nil : ([NSString stringWithFormat:@"@%@", replyAddress]) withId:msg]];
}

- (void)sendPing {
  id<GDJsonObject> msg = [GDJson createObject];
  (void) [((id<GDJsonObject>) nil_chk(msg)) set:@"type" value:@"ping"];
  [((id<ComGoodowRealtimeCoreWebSocket>) nil_chk(webSocket_)) sendWithNSString:[msg toJsonString]];
}

+ (void)initialize {
  if (self == [ComGoodowRealtimeChannelImplWebSocketBusClient class]) {
    ComGoodowRealtimeChannelImplWebSocketBusClient_log_ = [JavaUtilLoggingLogger getLoggerWithNSString:[[IOSClass classWithClass:[ComGoodowRealtimeChannelImplWebSocketBusClient class]] getName]];
  }
}

- (void)copyAllFieldsTo:(ComGoodowRealtimeChannelImplWebSocketBusClient *)other {
  [super copyAllFieldsTo:other];
  other->pingInterval_ = pingInterval_;
  other->pingTimerID_ = pingTimerID_;
  other->sessionID_ = sessionID_;
  other->webSocket_ = webSocket_;
}

+ (J2ObjcClassInfo *)__metadata {
  static J2ObjcMethodInfo methods[] = {
    { "sendOrPubWithBoolean:withNSString:withGDJsonElement:withId:", NULL, "V", 0x4, NULL },
    { "checkOpen", NULL, "V", 0x2, NULL },
    { "sendOrPubLocalWithBoolean:withNSString:withGDJsonElement:withId:", NULL, "V", 0x2, NULL },
    { "sendPing", NULL, "V", 0x2, NULL },
  };
  static J2ObjcFieldInfo fields[] = {
    { "log_", NULL, 0x1a, "LJavaUtilLoggingLogger" },
  };
  static J2ObjcClassInfo _ComGoodowRealtimeChannelImplWebSocketBusClient = { "WebSocketBusClient", "com.goodow.realtime.channel.impl", NULL, 0x1, 4, methods, 1, fields, 0, NULL};
  return &_ComGoodowRealtimeChannelImplWebSocketBusClient;
}

@end
@implementation ComGoodowRealtimeChannelImplWebSocketBusClient_$1

- (void)onClose {
  this$0_->state_ = [GDCStateEnum CLOSED];
  (void) [this$0_ publish:[NSString stringWithFormat:@"@%@", [GDCBus LOCAL_ON_CLOSE]] message:nil];
}

- (void)onErrorWithNSString:(NSString *)error {
  [((JavaUtilLoggingLogger *) nil_chk([ComGoodowRealtimeChannelImplWebSocketBusClient log])) warningWithNSString:error];
  (void) [this$0_ publish:[NSString stringWithFormat:@"@%@", [GDCBus LOCAL_ON_ERROR]] message:nil];
}

- (void)onMessageWithNSString:(NSString *)msg {
  id<GDJsonObject> json = [GDJson parseWithNSString:msg];
  NSString *replyAddress = [((id<GDJsonObject>) nil_chk(json)) getString:@"replyAddress"];
  NSString *address = [json getString:@"address"];
  ComGoodowRealtimeChannelImplDefaultMessage *message = [[ComGoodowRealtimeChannelImplDefaultMessage alloc] initWithBoolean:NO withGDCBus:this$0_ withNSString:address withNSString:replyAddress withId:[json getWithNSString:@"body"]];
  [this$0_ deliverMessageWithNSString:address withGDCMessage:message];
}

- (void)onOpen {
  [this$0_ sendPing];
  this$0_->pingTimerID_ = [((ComGoodowRealtimeCorePlatform *) nil_chk([ComGoodowRealtimeCorePlatform get])) setPeriodicWithInt:5000 withComGoodowRealtimeCoreVoidHandler:[[ComGoodowRealtimeChannelImplWebSocketBusClient_$1_$1 alloc] initWithComGoodowRealtimeChannelImplWebSocketBusClient_$1:self]];
  this$0_->state_ = [GDCStateEnum OPEN];
  (void) [this$0_ publish:[NSString stringWithFormat:@"@%@", [GDCBus LOCAL_ON_OPEN]] message:nil];
}

- (id)initWithComGoodowRealtimeChannelImplWebSocketBusClient:(ComGoodowRealtimeChannelImplWebSocketBusClient *)outer$ {
  this$0_ = outer$;
  return [super init];
}

+ (J2ObjcClassInfo *)__metadata {
  static J2ObjcFieldInfo fields[] = {
    { "this$0_", NULL, 0x1012, "LComGoodowRealtimeChannelImplWebSocketBusClient" },
  };
  static J2ObjcClassInfo _ComGoodowRealtimeChannelImplWebSocketBusClient_$1 = { "$1", "com.goodow.realtime.channel.impl", "WebSocketBusClient", 0x8000, 0, NULL, 1, fields, 0, NULL};
  return &_ComGoodowRealtimeChannelImplWebSocketBusClient_$1;
}

@end
@implementation ComGoodowRealtimeChannelImplWebSocketBusClient_$1_$1

- (void)handle {
  [this$0_->this$0_ sendPing];
}

- (id)initWithComGoodowRealtimeChannelImplWebSocketBusClient_$1:(ComGoodowRealtimeChannelImplWebSocketBusClient_$1 *)outer$ {
  this$0_ = outer$;
  return [super init];
}

+ (J2ObjcClassInfo *)__metadata {
  static J2ObjcMethodInfo methods[] = {
    { "handle", NULL, "V", 0x4, NULL },
  };
  static J2ObjcFieldInfo fields[] = {
    { "this$0_", NULL, 0x1012, "LComGoodowRealtimeChannelImplWebSocketBusClient_$1" },
  };
  static J2ObjcClassInfo _ComGoodowRealtimeChannelImplWebSocketBusClient_$1_$1 = { "$1", "com.goodow.realtime.channel.impl", "WebSocketBusClient$$1", 0x8000, 1, methods, 1, fields, 0, NULL};
  return &_ComGoodowRealtimeChannelImplWebSocketBusClient_$1_$1;
}

@end
@implementation ComGoodowRealtimeChannelImplWebSocketBusClient_$2

- (void)handleWithId:(id<GDCMessage>)msg {
  id<GDJsonObject> body = [((id<GDCMessage>) nil_chk(msg)) body];
  if ([@"ok" isEqual:[((id<GDJsonObject>) nil_chk(body)) getString:@"status"]]) {
    this$0_->sessionID_ = [body getString:@"sessionID"];
  }
  if (val$replyHandler_ != nil) {
    (void) [body remove:@"sessionID"];
    [this$0_ nativeHandleWithId:body withId:val$replyHandler_];
  }
}

- (id)initWithComGoodowRealtimeChannelImplWebSocketBusClient:(ComGoodowRealtimeChannelImplWebSocketBusClient *)outer$
                            withComGoodowRealtimeCoreHandler:(id<ComGoodowRealtimeCoreHandler>)capture$0 {
  this$0_ = outer$;
  val$replyHandler_ = capture$0;
  return [super init];
}

+ (J2ObjcClassInfo *)__metadata {
  static J2ObjcFieldInfo fields[] = {
    { "this$0_", NULL, 0x1012, "LComGoodowRealtimeChannelImplWebSocketBusClient" },
    { "val$replyHandler_", NULL, 0x1012, "LComGoodowRealtimeCoreHandler" },
  };
  static J2ObjcClassInfo _ComGoodowRealtimeChannelImplWebSocketBusClient_$2 = { "$2", "com.goodow.realtime.channel.impl", "WebSocketBusClient", 0x8000, 0, NULL, 2, fields, 0, NULL};
  return &_ComGoodowRealtimeChannelImplWebSocketBusClient_$2;
}

@end
