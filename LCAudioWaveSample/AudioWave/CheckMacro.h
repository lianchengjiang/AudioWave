//
//  CheckMacro.h
//  LcAudioWave
//
//  Created by jiangliancheng on 15/10/28.
//  Copyright © 2015年 jiangliancheng. All rights reserved.
//

#ifndef CheckMacro_h
#define CheckMacro_h


// check nil return nil
#define CNRN(x)         \
    if (!(x))           \
    {                   \
        return nil;     \
    }


// check nil return nil asset
#define CNRNA(x)        \
    if (!(x))           \
    {                   \
        assert(0);      \
        return nil;     \
    }


// check nil return nil asset
#define CNRA(x)         \
    if (!(x))           \
    {                   \
        assert(0);      \
        return  ;       \
    }


#define CNR(x)          \
    if (!(x))           \
    {                   \
        return  ;       \
    }


#endif /* CheckMacro_h */
