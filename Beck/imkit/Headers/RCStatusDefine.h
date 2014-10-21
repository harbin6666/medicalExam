//
//  RCStatusDefine.h
//  iOS-IMLib
//
//  Created by Heq.Shinoda on 14-6-15.
//  Copyright (c) 2014年 RongCloud. All rights reserved.
//
#import <Foundation/Foundation.h>
/**
 * 连接服务器的回调错误码。
 */
typedef NS_ENUM(NSInteger, RCConnectErrorCode)  {
    /**
     * 未知错误。
     */
    ConnectErrorCode_UNKNOWN = -1, //"Unknown error."
    
    /**
     * 数据包不完整。 请求数据包有缺失
     */
    ConnectErrorCode_PACKAGE_BROKEN = 2002, //"Package is broken."
    
    /**
     *
     * 服务器不可用。
     */
    ConnectErrorCode_SERVER_UNAVAILABLE = 2003,// "Server is unavailable."
    
    /**
     * 错误的令牌（Token），Token 解析失败。
     */
    ConnectErrorCode_TOKEN_INCORRECT = 2004, //"Token is incorrect."
    
    /**
     * App Key 不可用。
     *
     * 可能是错误的 App Key，或者 App Key 被服务器积极拒绝。
     */
    ConnectErrorCode_APP_KEY_UNAVAILABLE = 2005, //"App key is unavailable."
    
    /**
     * 数据库操作失败 1.目录无权限 2.创建目录失败 3.打开数据库失败 4.初始化数据库表失败
     */
    ConnectErrorCode_DATABASE_ERROR = 2006, //"Database is error"
    
    /**
     * 服务器超时。
     */
    ConnectErrorCode_TIMEOUT = 5004, //"Server is timed out."
    
    /**
     * 参数错误。
     */
    ConnectionStatus_INVALID_ARGUMENT = -1000
    
    
};

typedef NS_ENUM(NSInteger, RCConnectionStatus)
{
    /**
     * 未知错误。
     */
    ConnectionStatus_UNKNOWN = -1, //"Unknown error."
    
    
    /**
     * 连接成功。
     */
    ConnectionStatus_Connected = 0,
    
    /**
     * 网络不可用。
     */
    ConnectionStatus_NETWORK_UNAVAILABLE = 1, //"Network is unavailable."
    
    /**
     * 设备处于飞行模式。
     */
    ConnectionStatus_AIRPLANE_MODE = 2, //"Switch to airplane mode."
    
    /**
     * 设备处于 2G（GPRS、EDGE）低速网络下。
     */
    ConnectionStatus_Cellular_2G = 3,// "Switch to 2G cellular network."
    
    /**
     * 设备处于 3G 或 4G（LTE）高速网络下。
     */
    ConnectionStatus_Cellular_3G_4G = 4, //"Switch to 3G or 4G cellular network."
    
    /**
     * 设备网络切换到 WIFI 网络。
     */
    ConnectionStatus_WIFI = 5, //"Switch to WIFI network."
    
    /**
     * 用户账户在其他设备登录，本机会被踢掉线。
     */
    ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT = 6, //"Login on the other device, and be kicked offline."
    
    /**
     * 用户账户在 Web 端登录。
     */
    ConnectionStatus_LOGIN_ON_WEB = 7, //"Login on web client."
    
    /**
     * 服务器异常或无法连接。
     */
    ConnectionStatus_SERVER_INVALID = 8,
    
    /**
     * 验证异常(可能由于user验证、版本验证、auth验证)。
     */
    ConnectionStatus_VALIDATE_INVALID = 9,
    
};


//-----会话类型----//
typedef NS_ENUM(NSUInteger, RCConversationType)
{
    /**
     * 私聊
     */
    ConversationType_PRIVATE = 1,
    /**
     * 讨论组
     */
    ConversationType_DISCUSSION,
    /**
     * 群组
     */
    ConversationType_GROUP,
    /**
     * 聊天室
     */
    ConversationType_CHATROOM,
    /**
     *  客服消息
     */
    ConversationType_CUSTOMERSERVICE
};

/**
 * 消息方向枚举。
 */
typedef NS_ENUM(NSUInteger, RCMessageDirection) {
    /**
     * 发送
     */
    MessageDirection_SEND = 1,//false
    
    /**
     * 接收
     */
    MessageDirection_RECEIVE//true
};
/**
 * 媒体文件类型枚举。
 */
typedef NS_ENUM(NSUInteger, RCMediaType)
{
    /**
     * 图片。
     */
    MediaType_IMAGE = 1,
    
    /**
     * 声音。
     */
    MediaType_AUDIO,
    
    /**
     * 视频。
     */
    MediaType_VIDEO,
    
    /**
     * 通用文件。
     */
    MediaType_FILE = 100
};

/**
 *  消息记录状态
 */
typedef NS_OPTIONS(NSUInteger, RCMessagePersistent) {
    MessagePersistent_NONE = 0,
    MessagePersistent_ISPERSISTED = 1 << 0,
    MessagePersistent_ISCOUNTED = 1 << 1
};

/**
 * 发送出的消息的状态。
 */
typedef NS_ENUM(NSUInteger, RCSentStatus)
{
    /**
     * 发送中。
     */
    SentStatus_SENDING = 10,
    
    /**
     * 发送失败。
     */
    SentStatus_FAILED = 20,
    
    /**
     * 已发送。
     */
    SentStatus_SENT = 30,
    
    /**
     * 对方已接收。
     */
    SentStatus_RECEIVED = 40,
    
    /**
     * 对方已读。
     */
    SentStatus_READ = 50,
    
    /**
     * 对方已销毁。
     */
    SentStatus_DESTROYED = 60
};

//----消息阅读状态----//
typedef NS_ENUM(NSUInteger, RCReceivedStatus)
{
    /**
     * 未读。
     */
    ReceivedStatus_UNREAD = 0,
    /**
     * 已读。
     */
    ReceivedStatus_READ = 1,
    /**
     * 未读。
     */
    ReceivedStatus_LISTENED = 2,
    
    ReceivedStatus_DOWNLOADED = 4,
    
};

//----
typedef NS_ENUM(NSInteger, RCErrorCode)
{
    ErrorCode_UNKNOWN = -1,
    ErrorCode_TIMEOUT = 5004
};

typedef NS_ENUM(NSUInteger, RCConversationNotificationStatus)
{
    //免打扰
    DO_NOT_DISTURB = 0,
    //新消息阻止枚举
    NOTIFY = 1,
};

#define KNotificationCenterRCMessageReceiver @"NotificationCenterRCMessageReceiver"

#define RCTextMessageTypeIdentifier @"RC:TxtMsg"
#define RCImageMessageTypeIdentifier @"RC:ImgMsg"
#define RCVoiceMessageTypeIdentifier @"RC:VcMsg"
#define RCDiscussionNotificationTypeIdentifier @"RC:DizNtf"
#define RCImageTextMessageTypeIdentifier @"RC:ImgTextMsg"
