//
//  PPMyLiveViewController.swift
//  live
//
//  Created by chenpeiwei on 3/10/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit
import VideoCore

class PPMyLiveViewController: UIViewController,VCSessionDelegate {
    
    var previewView:UIView!
//    var session:VCSimpleSession = VCSimpleSession(videoSize: CGSize(width: 1280, height: 720), frameRate: 30, bitrate: 1000000, useInterfaceOrientation: false)
    var session:VCSimpleSession = VCSimpleSession(videoSize: CGSize(width: ScreenSize.SCREEN_WIDTH, height: ScreenSize.SCREEN_HEIGHT), frameRate: 15, bitrate: 500000, useInterfaceOrientation: true, cameraState: .Front, aspectMode: VCAspectMode.AspectModeFit)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        previewView = UIView(frame: view.bounds)
        view .addSubview(previewView)
        self.previewView.transform = CGAffineTransformMakeScale(-1.0, 1.0);

        previewView.addSubview(session.previewView)
        session.previewView.frame = previewView.bounds
        session.cameraState = VCCameraState.Front
        session.delegate = self
        
        let button = UIButton(type: .Custom)
        button.frame = CGRectMake(0, 10, 100, 50)
        button .setTitle("switch", forState: .Normal)
        button.addTarget(self, action: "switchCamera", forControlEvents: .TouchUpInside)
        
        let button2 = UIButton(type: .Custom)
        button2.frame = CGRectMake(300, 10, 100, 50)
        button2 .setTitle("X", forState: .Normal)
        button2.addTarget(self, action: "dismissSelf", forControlEvents: .TouchUpInside)
        
        self.view .addSubview(button)
        self.view .addSubview(button2)

        connect()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        session.delegate = nil;
    }
    
    func dismissSelf() {
        session .endRtmpSession()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func switchCamera() {
        switch session.cameraState {
        case .Front:
            session.cameraState = .Back
            self.previewView.transform = CGAffineTransformMakeScale(1.0, 1.0);

        case .Back:
            session.cameraState = .Front
            self.previewView.transform = CGAffineTransformMakeScale(-1.0, 1.0);
        }
    }
     func connect() {
        switch session.rtmpSessionState {
        case .None, .PreviewStarted, .Ended, .Error:
            session.startRtmpSessionWithURL("rtmp://119.29.142.208/live/", andStreamKey: "peiwei")
            //            /119.29.142.208/live/cam2
        default:
            session.endRtmpSession()
            break
        }
    }
    
    
    
    func switchFilter() {
        switch self.session.filter {
            
        case .Normal:
            self.session.filter = .Gray
            
        case .Gray:
            self.session.filter = .InvertColors
            
        case .InvertColors:
            self.session.filter = .Sepia
            
        case .Sepia:
            self.session.filter = .Fisheye
            
        case .Fisheye:
            self.session.filter = .Glow
            
        case .Glow:
            self.session.filter = .Normal
        }
    }
    
    func connectionStatusChanged(sessionState: VCSessionState) {
        debugPrint("connectionStatusChanged sessionState\(sessionState)")
        switch sessionState {
        case .None:
            print("connectionStatusChanged None")
            break
        case .PreviewStarted:
            print("connectionStatusChanged PreviewStarted")
            break
        case .Started:
            print("connectionStatusChanged Started")
            break
        case .Starting:
            print("connectionStatusChanged Starting")
            break
        case .Ended:
            print("connectionStatusChanged Ended")
            connect()
            break
        case .Error:
            print("connectionStatusChanged Error reconnect")
            session .endRtmpSession()
            break

        }
    }
}
