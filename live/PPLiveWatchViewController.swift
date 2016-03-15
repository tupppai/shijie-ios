//
//  PPLiveWatchViewController.swift
//  live
//
//  Created by chenpeiwei on 3/14/16.
//  Copyright © 2016 Pires.Inc. All rights reserved.
//

import UIKit

class PPLiveWatchViewController: UIViewController {
    
    var player:PLPlayer!
    
    override func viewDidLoad() {
//        // 初始化 PLPlayerOption 对象
//        PLPlayerOption *option = [PLPlayerOption defaultOption];
//        
//        // 更改需要修改的 option 属性键所对应的值
//        [option setOptionValue:@15 forKey:PLPlayerOptionKeyTimeoutIntervalForMediaPackets];
//
//        PLPlayerOption *option = [PLPlayerOption defaultOption];
//        [option setOptionValue:@15 forKey:PLPlayerOptionKeyTimeoutIntervalForMediaPackets];
//        
//        self.player = [PLPlayer playerWithURL:self.URL option:option];
//        self.player.delegate = self;
        let option = PLPlayerOption.defaultOption()
        option .setOptionValue(NSNumber(integer: 3), forKey:PLPlayerOptionKeyTimeoutIntervalForMediaPackets)
        player = PLPlayer(URL: NSURL(string: "rtmp://119.29.142.208/live/peiwei"), option: option)
        view .addSubview(player.playerView!)
        player .play()
        
//        let urlString = "rtmp://119.29.142.208/live/peiwei".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())

    }
    
  
}


extension PPLiveWatchViewController {
    

}
