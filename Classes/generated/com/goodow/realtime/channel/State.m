//
//  Generated by the J2ObjC translator.  DO NOT EDIT!
//  source: /Users/retechretech/dev/workspace/realtime/realtime-channel/src/main/java/com/goodow/realtime/channel/State.java
//
//  Created by retechretech.
//

#include "IOSClass.h"
#include "com/goodow/realtime/channel/State.h"
#include "java/lang/IllegalArgumentException.h"


static GDCStateEnum *GDCStateEnum_CONNECTING;
static GDCStateEnum *GDCStateEnum_OPEN;
static GDCStateEnum *GDCStateEnum_CLOSING;
static GDCStateEnum *GDCStateEnum_CLOSED;
IOSObjectArray *GDCStateEnum_values;

@implementation GDCStateEnum

+ (GDCStateEnum *)CONNECTING {
  return GDCStateEnum_CONNECTING;
}
+ (GDCStateEnum *)OPEN {
  return GDCStateEnum_OPEN;
}
+ (GDCStateEnum *)CLOSING {
  return GDCStateEnum_CLOSING;
}
+ (GDCStateEnum *)CLOSED {
  return GDCStateEnum_CLOSED;
}

- (id)copyWithZone:(NSZone *)zone {
  return self;
}

- (id)initWithNSString:(NSString *)__name withInt:(int)__ordinal {
  return [super initWithNSString:__name withInt:__ordinal];
}

+ (void)initialize {
  if (self == [GDCStateEnum class]) {
    GDCStateEnum_CONNECTING = [[GDCStateEnum alloc] initWithNSString:@"CONNECTING" withInt:0];
    GDCStateEnum_OPEN = [[GDCStateEnum alloc] initWithNSString:@"OPEN" withInt:1];
    GDCStateEnum_CLOSING = [[GDCStateEnum alloc] initWithNSString:@"CLOSING" withInt:2];
    GDCStateEnum_CLOSED = [[GDCStateEnum alloc] initWithNSString:@"CLOSED" withInt:3];
    GDCStateEnum_values = [[IOSObjectArray alloc] initWithObjects:(id[]){ GDCStateEnum_CONNECTING, GDCStateEnum_OPEN, GDCStateEnum_CLOSING, GDCStateEnum_CLOSED, nil } count:4 type:[IOSClass classWithClass:[GDCStateEnum class]]];
  }
}

+ (IOSObjectArray *)values {
  return [IOSObjectArray arrayWithArray:GDCStateEnum_values];
}

+ (GDCStateEnum *)valueOfWithNSString:(NSString *)name {
  for (int i = 0; i < [GDCStateEnum_values count]; i++) {
    GDCStateEnum *e = GDCStateEnum_values->buffer_[i];
    if ([name isEqual:[e name]]) {
      return e;
    }
  }
  @throw [[JavaLangIllegalArgumentException alloc] initWithNSString:name];
  return nil;
}

+ (J2ObjcClassInfo *)__metadata {
  static const char *superclass_type_args[] = {"LGDCStateEnum"};
  static J2ObjcClassInfo _GDCStateEnum = { "State", "com.goodow.realtime.channel", NULL, 0x4011, 0, NULL, 0, NULL, 1, superclass_type_args};
  return &_GDCStateEnum;
}

@end
