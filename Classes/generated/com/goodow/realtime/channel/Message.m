//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/retechretech/dev/workspace/realtime/realtime-channel/src/main/java/com/goodow/realtime/channel/Message.java
//
//  Created by retechretech.
//

#include "com/goodow/realtime/channel/Message.h"
#include "com/goodow/realtime/core/Handler.h"
#include "com/goodow/realtime/json/JsonElement.h"


@interface GDCMessage : NSObject
@end

@implementation GDCMessage

+ (J2ObjcClassInfo *)__metadata {
  static J2ObjcMethodInfo methods[] = {
    { "address", NULL, "LNSString", 0x401, NULL },
    { "body", NULL, "TT", 0x401, NULL },
    { "replyAddress", NULL, "LNSString", 0x401, NULL },
  };
  static J2ObjcClassInfo _GDCMessage = { "Message", "com.goodow.realtime.channel", NULL, 0x201, 3, methods, 0, NULL, 0, NULL};
  return &_GDCMessage;
}

@end
