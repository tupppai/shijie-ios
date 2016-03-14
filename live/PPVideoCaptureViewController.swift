//
//  ViewController.swift
//  live
//
//  Created by chenpeiwei on 3/4/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit
import AVFoundation

class PPVideoCaptureViewController: UIViewController,AVCaptureVideoDataOutputSampleBufferDelegate {
    lazy var session = AVCaptureSession();
    var videoQueue:dispatch_queue_t!
    var videoOutput:AVCaptureVideoDataOutput!
    var videoConnection:AVCaptureConnection!
    var previewLayer:AVCaptureVideoPreviewLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.greenColor()
        self.setupPreviewLayer()
        self.setupSession()
    }
    
    func setupSession() {
        // 获得一个采集设备，例如前置/后置摄像头
        let videoDevice = self.cameraWithPosition(AVCaptureDevicePosition.Front);
        if videoDevice == nil {
            return
        }
        // 用设备初始化一个采集的输入对象
        let videoInput:AVCaptureDeviceInput
        do {
            videoInput = try AVCaptureDeviceInput(device: videoDevice)
        } catch {
            return;
        }
        
        if session.canAddInput(videoInput) {
            session.addInput(videoInput)
        }
        
        // 配置采集输出，即我们取得视频图像的接口
        videoQueue = dispatch_queue_create("VideoCaptureQueue", DISPATCH_QUEUE_SERIAL);
        videoOutput = AVCaptureVideoDataOutput()
        videoOutput.setSampleBufferDelegate(self, queue: videoQueue);
        // 配置输出视频图像格式  kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange, kCVPixelFormatType_420YpCbCr8BiPlanarFullRange and kCVPixelFormatType_32BGRA.
        videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey: NSNumber(unsignedInt: kCVPixelFormatType_32BGRA)];
        videoOutput.alwaysDiscardsLateVideoFrames = true;
        if session.canAddOutput(videoOutput) {
            session .addOutput(videoOutput)
        }
        
        // 保存Connection，用于在SampleBufferDelegate中判断数据来源（是Video/Audio？）
        videoConnection = videoOutput.connectionWithMediaType(AVMediaTypeVideo)
        
        session.startRunning()
    }
    
    func setupPreviewLayer() {
        
        self.previewLayer = AVCaptureVideoPreviewLayer(session: self.session);
        self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        self.previewLayer.frame = self.view.layer.bounds;
        self.view.layer.addSublayer(self.previewLayer);
        
        let button = UIButton(frame: CGRect(origin: CGPointMake(10, 20), size: CGSizeMake(100, 20)))
        button.setTitle("switch", forState: UIControlState.Normal)
        self.previewLayer .addSublayer(button.layer);
        button .addTarget(self, action: "switchCameraPosition", forControlEvents: .TouchUpInside)
        
        let button2 = UIButton(frame: CGRect(origin: CGPointMake(200, 20), size: CGSizeMake(100, 20)))
        button2.setTitle("login", forState: UIControlState.Normal)
        self.previewLayer .addSublayer(button2.layer);
        button2.addTarget(self, action: "toLogin", forControlEvents: .TouchUpInside)
    }
    
    func toLogin() {
        self .presentViewController(PPLoginViewController(), animated: true, completion: nil)
    }
    func cameraWithPosition(position:AVCaptureDevicePosition!)->AVCaptureDevice? {
        let devices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo);
        for device in devices {
            if device.position == position {
                return device as? AVCaptureDevice;
            }
        }
        return nil;
    }
    
    //切换摄像头  前／后
    func switchCameraPosition() {
        session.beginConfiguration()
        let currentCameraInput = session.inputs[0] as! AVCaptureInput
        session .removeInput(currentCameraInput)
        
        var newCamera:AVCaptureDevice?
        if (currentCameraInput as! AVCaptureDeviceInput).device.position == AVCaptureDevicePosition.Back {
            newCamera = self.cameraWithPosition(AVCaptureDevicePosition.Front)
        } else {
            newCamera = self.cameraWithPosition(AVCaptureDevicePosition.Back)
        }
        if newCamera == nil {
            return;
        }
        
        do {
            let newDeviceInput = try AVCaptureDeviceInput(device: newCamera)
            self.session .addInput(newDeviceInput)
        }catch {
            return;
        }
        self.session.commitConfiguration()
    }

    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        if connection == videoConnection {
//            // sampleBuffer now contains an individual frame of raw video frames
////            CVPixelBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
////            
////            CVPixelBufferLockBaseAddress(pixelBuffer, 0);
////            
////            // access the data
////            int width = CVPixelBufferGetWidth(pixelBuffer);
////            int height = CVPixelBufferGetHeight(pixelBuffer);
////            int bytesPerRow = CVPixelBufferGetBytesPerRowOfPlane(pixelBuffer, 0);
////            unsigned char *rawPixelBase = (unsigned char *)CVPixelBufferGetBaseAddressOfPlane(pixelBuffer, 0);
//            let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
//            CVPixelBufferLockBaseAddress(pixelBuffer, 0)
//            let width = CVPixelBufferGetWidth(pixelBuffer)
//            let height = CVPixelBufferGetHeight(pixelBuffer)
//            let bytesPerRow = CVPixelBufferGetBytesPerRowOfPlane(pixelBuffer, 0)
//            let rawPixelBase = CVPixelBufferGetBaseAddressOfPlane(pixelBuffer, 0)
//            
//            var codec:UnsafeMutablePointer<AVCodec>
//            var context:UnsafeMutablePointer<AVCodecContext>
//            var frame:AVFrame
//            let packet:AVPacket
//            avcodec_register_all()
//            codec = avcodec_find_encoder(AV_CODEC_ID_H264);
//            
//            if codec == nil {
//                
//            }
//            
//            context = avcodec_alloc_context3(codec);
//            if context == nil {
//                
//            }
//            // 为媒体数据设置一个CMSampleBuffer的Core Video图像缓存对象
//            CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
//            // 锁定pixel buffer的基地址
//            if (kCVReturnSuccess == CVPixelBufferLockBaseAddress(imageBuffer, 0)) {
//                // 得到pixel buffer的基地址
//                uint8_t *bufferPtr = (uint8_t *)CVPixelBufferGetBaseAddressOfPlane(imageBuffer,0);
//                uint8_t *uvPtr = (uint8_t *)CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 1);
//                size_t bufferSize = CVPixelBufferGetDataSize(imageBuffer);
//                NSLog(@"=== buffsize : %zu",bufferSize);
//                bool isPlanar = CVPixelBufferIsPlanar(imageBuffer);
//                if (isPlanar) {
//                    int planeCount = CVPixelBufferGetPlaneCount(imageBuffer);
//                    NSLog(@"=== planeCount : %d \n ",planeCount);
//                }
//                size_t ysize = 640*480;
//                uint8_t *newbuffer = (uint8_t *)malloc(ysize*1.5);
//                memcpy(newbuffer, bufferPtr, ysize*1.5);
//                //        if (self.delegate && [self.delegate respondsToSelector:@selector(videoOutPut:dataSize:)]) {
//                //
//                //            [self.delegate videoOutPut:(uint8_t *)newbuffer dataSize:bufferSize];
//                //
//                //        }
//                [self videoOutPut:newbuffer dataSize:bufferSize];
//                free(newbuffer);
//                // 解锁pixel buffer
//                CVPixelBufferUnlockBaseAddress(imageBuffer,0);
//            }
            
            let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)!
            
            if kCVReturnSuccess == CVPixelBufferLockBaseAddress(imageBuffer, 0) {
                let bufferPtr = CVPixelBufferGetBaseAddressOfPlane(imageBuffer,0)
                let uvPtr = CVPixelBufferGetBaseAddressOfPlane(imageBuffer,1)
                let bufferSize:size_t = CVPixelBufferGetDataSize(imageBuffer)
                print("bufferPtr \(bufferPtr) uvPtr\(uvPtr) bufferSize\(bufferSize)")
                
//                bool isPlanar = CVPixelBufferIsPlanar(imageBuffer);
//                if (isPlanar) {
//                    int planeCount = CVPixelBufferGetPlaneCount(imageBuffer);
//                    NSLog(@"=== planeCount : %d \n ",planeCount);
//                }
//                size_t ysize = 640*480;
//                uint8_t *newbuffer = (uint8_t *)malloc(ysize*1.5);
//                memcpy(newbuffer, bufferPtr, ysize*1.5);
                if CVPixelBufferIsPlanar(imageBuffer) {
                    let planeCount = CVPixelBufferGetPlaneCount(imageBuffer)
                    print("planeCount\(planeCount)")
                }
                let ysize:Double = 640*480
                let newbuffer = malloc( (Int)(ysize*1.5))
                memcpy(newbuffer, bufferPtr, (Int)(ysize*1.5))
//                [self videoOutPut:newbuffer dataSize:bufferSize];
                CVPixelBufferUnlockBaseAddress(imageBuffer, 0)
//                avformat_alloc_output_context2(<#T##ctx: UnsafeMutablePointer<UnsafeMutablePointer<AVFormatContext>>##UnsafeMutablePointer<UnsafeMutablePointer<AVFormatContext>>#>, <#T##oformat: UnsafeMutablePointer<AVOutputFormat>##UnsafeMutablePointer<AVOutputFormat>#>, <#T##format_name: UnsafePointer<Int8>##UnsafePointer<Int8>#>, filename: UnsafePointer<Int8>)
            }
            
            
        }
        
        
//        int encoderH264(BOBOAACEncoder *encoder,uint8_t *inputBuffer,size_t bufferSize)
//        {
//            AVFrame *frame = avcodec_alloc_frame();
//            frame->pts = picFrameIndex;
//            //    int ysize = encoder->pVideoCodecCtx->width *encoder->pVideoCodecCtx->height;
//            av_init_packet(&encoder->videoPacket);
//            int gotPicture = 0;
//            //将原数据填充到AVFrame结构里，便于进行编码
//            avpicture_fill((AVPicture *)frame, inputBuffer, encoder->pVideoCodecCtx->pix_fmt, encoder->pVideoCodecCtx->width, encoder->pVideoCodecCtx->height);
//            encoder->videoPacket.data = NULL;
//            encoder->videoPacket.size = 0;
//            // 进行H264编码
//            int ret = avcodec_encode_video2(encoder->pVideoCodecCtx, &encoder->videoPacket, frame, &gotPicture);
//            picFrameIndex++;
//            if (ret < 0) {
//                printf("avcodec_fill_video_frame error !\n");
//                av_frame_free(&frame);
//                av_free_packet(&encoder->videoPacket);
//                return -1;
//            }
//            // 成功编码一祯数据
//            if (gotPicture == 1) {
//                encoder->videoPacket.stream_index = encoder->pVideoStrem->index;
//                encoder->videoPacket.pts = frame->pts;
//                //写入到指定的地方 由encoder->pFormatCtx 保存着输出的路径
//                ret = av_interleaved_write_frame(encoder->pFormatCtx, &encoder->videoPacket);
//            }
//            av_frame_free(&frame);
//            av_free_packet(&encoder->videoPacket);
//            return 1;
//        }
    }
    
    
}

