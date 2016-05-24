//
//  PLCameraStreamingSession.h
//  PLCameraStreamingKit
//
//  Created on 15/4/1.
//  Copyright (c) 2015年 Pili Engineering. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "PLSourceAccessProtocol.h"
#import "PLCameraMacroDefines.h"
#import "PLCameraSource.h"
#import "PLStreamingKit.h"

// post with userinfo @{@"state": @(state)}. always posted via MainQueue.
extern NSString *PLStreamStateDidChangeNotification;
extern NSString *PLCameraAuthorizationStatusDidGetNotificaiton;
extern NSString *PLMicrophoneAuthorizationStatusDidGetNotificaiton;

extern NSString *PLCameraDidStartRunningNotificaiton;
extern NSString *PLMicrophoneDidStartRunningNotificaiton;
extern NSString *PLAudioComponentFailedToCreateNotification;

@class PLCameraStreamingSession, PLVideoStreamingConfiguration, PLAudioStreamingConfiguration, PLStream, PLStreamStatus;
@protocol PLStreamingSendingBufferDelegate;

/// @abstract delegate 对象可以实现对应的方法来获取流的状态及设备授权情况。
@protocol PLCameraStreamingSessionDelegate <NSObject>

@optional
/// @abstract 流状态已变更的回调
- (void)cameraStreamingSession:(PLCameraStreamingSession *)session streamStateDidChange:(PLStreamState)state;

/// @abstract 因产生了某个 error 而断开时的回调
- (void)cameraStreamingSession:(PLCameraStreamingSession *)session didDisconnectWithError:(NSError *)error;

/// @abstract 当开始推流时，会每间隔 3s 调用该回调方法来反馈该 3s 内的流状态，包括视频帧率、音频帧率、音视频总码率
- (void)cameraStreamingSession:(PLCameraStreamingSession *)session streamStatusDidUpdate:(PLStreamStatus *)status;

/// @abstract 摄像头授权状态发生变化的回调
- (void)cameraStreamingSession:(PLCameraStreamingSession *)session didGetCameraAuthorizationStatus:(PLAuthorizationStatus)status;

/// @abstract 麦克风授权状态发生变化的回调
- (void)cameraStreamingSession:(PLCameraStreamingSession *)session didGetMicrophoneAuthorizationStatus:(PLAuthorizationStatus)status;

/// @abstract 获取到摄像头原数据时的回调, 便于开发者做滤镜等处理
- (CMSampleBufferRef)cameraStreamingSession:(PLCameraStreamingSession *)session cameraSourceDidGetSampleBuffer:(CMSampleBufferRef)sampleBuffer;

@end

/*!
 * @abstract 推流中的核心类。
 *
 * @discussion 一个 PLCameraStreamingSession 实例会包含了对视频源、音频源的控制，并且对流的操作及流状态的返回都是通过它来完成的。
 */
@interface PLCameraStreamingSession : NSObject


/// 视频编码及推流配置
@property (nonatomic, PL_STRONG) PLVideoStreamingConfiguration  *videoConfiguration;

/// 音频编码及推流配置
@property (nonatomic, PL_STRONG) PLAudioStreamingConfiguration  *audioConfiguration;

/// 流对象
@property (nonatomic, PL_STRONG) PLStream   *stream;

/// 获取和设置视频方向
@property (nonatomic, assign) AVCaptureVideoOrientation    videoOrientation;

/// 代理对象
@property (nonatomic, PL_WEAK) id<PLCameraStreamingSessionDelegate> delegate;

/// 流的状态，只读属性
@property (nonatomic, assign, readonly) PLStreamState               streamState;

/// 默认为 3s，可设置范围为 [1..30] 秒
@property (nonatomic, assign) NSTimeInterval    statusUpdateInterval;

/*!
 * 是否开始推流，只读属性
 *
 * @discussion 该状态表达的是 streamingSession 有没有开始推流。当 streamState 为 PLStreamStateConnecting 或者 PLStreamStateConnected 时, isRunning 都会为 YES，所以它为 YES 时并不表示流一定已经建立连接，其从广义上表达 streamingSession 作为客户端对象的状态。
 */
@property (nonatomic, assign, readonly) BOOL                        isRunning;

/*!
 * @abstract 摄像头的预览视图
 *
 * @discussion 在设置预览视图时，请确保 previewView 的 size 已经设置正确。
 */
@property (nonatomic, PL_WEAK) UIView *previewView;

/*!
 * 初始化方法
 *
 * @param videoConfiguration 视频编码及推流的配置信息
 *
 * @param audioConfiguration 音频编码及推流的配置信息
 *
 * @param stream Stream 对象
 *
 * @param videoOrientation 视频方向
 *
 * @return PLCameraStreamingSession 实例
 *
 * @discussion 初始化方法会优先使用后置摄像头，如果发现设备没有后置摄像头，会判断是否有前置摄像头，如果都没有，便会返回 nil。
 */
- (instancetype)initWithVideoConfiguration:(PLVideoStreamingConfiguration *)videoConfiguration
                        audioConfiguration:(PLAudioStreamingConfiguration *)audioConfiguration
                                    stream:(PLStream *)stream
                          videoOrientation:(AVCaptureVideoOrientation)videoOrientation;

/*!
 * 销毁 session 的方法
 *
 * @discussion 销毁 StreamingSession 的方法，销毁前不需要调用 stop 方法。
 */
- (void)destroy;

// RTMP Operations
/*!
 * 开始推流
 *
 * @param pushURL 推流地址
 *
 * @param handler 流连接的结果会通过该回调方法返回
 *
 * @discussion 当调用过一次并且开始推流时，如果再调用该方法会直接返回不会做任何操作，尽管如此，也不要在没有断开时重复调用该方法。
 */
- (void)startWithCompleted:(void (^)(BOOL success))handler;

/*!
 * 结束推流
 */
- (void)stop;

/*!
 * 更新 previewView 的大小
 *
 * @param size 新的大小
 *
 * @discussion 该方法并不会变更编码视频的大小，只会改变当前设备摄像预览视图的尺寸
 */
- (void)updatePreviewViewSize:(CGSize)size;

- (void)reloadVideoConfiguration:(PLVideoStreamingConfiguration *)videoConfiguration;

@end

#pragma mark - Category (SendingBuffer)

@interface PLCameraStreamingSession (SendingBuffer)

@property (nonatomic, PL_WEAK) id<PLStreamingSendingBufferDelegate> bufferDelegate;

/// [0..1], 不可超出这个范围, 默认为 0.5
@property (nonatomic, assign) CGFloat threshold;

/// Buffer 最多可包含的包数，默认为 300
@property (nonatomic, assign) NSUInteger    maxCount;
@property (nonatomic, assign, readonly) NSUInteger    currentCount;


/// 已弃用，最低阈值, [0..1], 不可超出这个范围, 默认为 0.5
@property (nonatomic, assign) CGFloat    lowThreshold DEPRECATED_ATTRIBUTE;
/// 已弃用，最高阈值, [0..1], 不可超出这个范围, 默认为 1
@property (nonatomic, assign) CGFloat    highThreshold DEPRECATED_ATTRIBUTE;

@end

#pragma mark - Category (CameraSource)

/*!
 * @category PLCameraStreamingSession(CameraSource)
 *
 * @discussion 与摄像头相关的接口
 */
@interface PLCameraStreamingSession (CameraSource)

/// default as AVCaptureDevicePositionBack.
@property (nonatomic, assign) PLCaptureDevicePosition   captureDevicePosition;

/// default as NO.
@property (nonatomic, assign, getter=isTorchOn) BOOL    torchOn;

/// default as (0.5, 0.5), (0,0) is top-left, (1,1) is bottom-right.
@property (nonatomic, assign) CGPoint   focusPointOfInterest;

/// default as YES.
@property (nonatomic, assign, getter=isContinuousAutofocusEnable) BOOL  continuousAutofocusEnable;

/// default as YES.
@property (nonatomic, assign, getter=isTouchToFocusEnable) BOOL touchToFocusEnable;

/// default as YES.
@property (nonatomic, assign, getter=isSmoothAutoFocusEnabled) BOOL  smoothAutoFocusEnabled;

/// 默认为 1.0，设置的数值需要小于等于 videoActiveForat.videoMaxZoomFactor，如果大于会设置失败。
@property (nonatomic, assign) CGFloat videoZoomFactor;

@property (nonatomic, retain) AVCaptureDeviceFormat *videoActiveFormat;


- (void)toggleCamera;

/*!
 * 开启摄像头 session
 *
 * @discussion 这个方法一般不需要调用，但当你的 App 中需要同时使用到 AVCaptureSession 时，在调用过 - (void)stopCaptureSession 方法后，
 * 如果要重新启用推流的摄像头，可以调用这个方法
 *
 * @see - (void)stopCaptureSession
 */
- (void)startCaptureSession;

/*!
 * 停止摄像头 session
 *
 * @discussion 这个方法一般不需要调用，但当你的 App 中需要同时使用到 AVCaptureSession 时，当你需要暂且切换到你自己定制的摄像头做别的操作时，
 * 你需要调用这个方法来暂停当前 streaming session 对 captureSession 的占用。当需要恢复时，调用 - (void)startCaptureSession 方法。
 *
 * @see - (void)startCaptureSession
 */
- (void)stopCaptureSession;

@end

#pragma mark - Category (MicrophoneSource)

/*!
 * @category PLCameraStreamingSession(MicrophoneSource)
 *
 * @discussion 与麦克风相关的接口
 */
@interface PLCameraStreamingSession (MicrophoneSource)

@property (nonatomic, assign, getter=isMuted)   BOOL    muted;                   // default as NO.

@end

#pragma mark - Categroy (Application)

/*!
 * @category PLCameraStreamingSession(Application)
 *
 * @discussion 与系统相关的接口
 */
@interface PLCameraStreamingSession (Application)

@property (nonatomic, assign, getter=isIdleTimerDisable) BOOL  idleTimerDisable;   // default as YES.

@end

#pragma mark - Category (Authorization)

/*!
 * @category PLCameraStreamingSession(Authorization)
 *
 * @discussion 与设备授权相关的接口
 */
@interface PLCameraStreamingSession (Authorization)

// Camera
+ (PLAuthorizationStatus)cameraAuthorizationStatus;
+ (void)requestCameraAccessWithCompletionHandler:(void (^)(BOOL granted))handler;

// Microphone
+ (PLAuthorizationStatus)microphoneAuthorizationStatus;
+ (void)requestMicrophoneAccessWithCompletionHandler:(void (^)(BOOL granted))handler;

@end