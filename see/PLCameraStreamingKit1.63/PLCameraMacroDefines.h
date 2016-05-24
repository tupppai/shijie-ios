//
//  PLCameraMacroDefines.h
//  PLCameraStreamingKit
//
//  Created on 15/3/26.
//  Copyright (c) 2015年 Pili Engineering. All rights reserved.
//

#ifndef PLCameraStreamingKit_PLCameraMacroDefines_h
#define PLCameraStreamingKit_PLCameraMacroDefines_h

#ifndef PL_STRONG
    #if __has_feature(objc_arc)
        #define PL_STRONG strong
    #else
        #define PL_STRONG retain
    #endif
#endif

#ifndef PL_WEAK
    #if __has_feature(objc_arc)
        #define PL_WEAK weak
    #else
        #define PL_WEAK assign
    #endif
#endif

#ifndef PL_DEALLOC
    #if __has_feature(objc_arc)
        #define PL_DEALLOC
    #else
        #define PL_DEALLOC dealloc
    #endif
#endif

#endif
